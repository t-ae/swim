#if canImport(CoreGraphics)

import CoreGraphics

// MARK: - Protocol
public protocol ConvertibleToCGImage: PixelType {
    static func toCGImage(image: Image<Self, UInt8>) -> CGImage
}

public protocol ConvertibleFromCGImage: PixelType {
    static func fromCGImage(cgImage: CGImage) -> Image<Self, UInt8>
}

// MARK: - Image
extension Image where P: ConvertibleFromCGImage, T == UInt8 {
    /// Create Image from CGImage.
    @inlinable
    public init(cgImage: CGImage) {
        self = P.fromCGImage(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T == UInt8 {
    /// Create CGImage.
    @inlinable
    public func cgImage() -> CGImage {
        return P.toCGImage(image: self)
    }
}

extension Image where P: ConvertibleFromCGImage, T: BinaryFloatingPoint {
    /// Create Image from CGImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public init(cgImage: CGImage) {
        let uint8 = Image<P, UInt8>(cgImage: cgImage)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P: ConvertibleToCGImage, T: BinaryFloatingPoint {
    /// Create CGImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public func cgImage() -> CGImage {
        var i255 = clipped(low: 0, high: 1) * 255
        i255.round()
        let uint8 = Image<P, UInt8>(cast: i255)
        return uint8.cgImage()
    }
}

// MARK: - Intensity
extension Intensity: ConvertibleFromCGImage, ConvertibleToCGImage {
    @inlinable
    public static func fromCGImage(cgImage: CGImage) -> Image<Intensity, UInt8> {
        let width = cgImage.width
        let height = cgImage.height
        
        var data = [UInt8](repeating: 0, count: cgImage.bytesPerRow*height)
        let context = CGContext(data: &data,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width,
                                space: CGColorSpaceCreateDeviceGray(),
                                bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).rawValue)!
        context.clear(CGRect(x: 0, y: 0, width: width, height: height))
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return Image(width: cgImage.width, height: cgImage.height, data: data)
    }
    
    @inlinable
    public static func toCGImage(image: Image<Intensity, UInt8>) -> CGImage {
        let bitsPerComponent = MemoryLayout<UInt8>.size * 8
        let bitsPerPixel = bitsPerComponent
        let bytesPerRow = image.width * bitsPerPixel / 8
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
            .union(CGBitmapInfo.byteOrder32Big)
        
        let data = image.data
        let cfData = CFDataCreate(nil, data, data.count)!
        let dataProvider = CGDataProvider(data: cfData)!
        
        return CGImage(width: image.width,
                       height: image.height,
                       bitsPerComponent: bitsPerComponent,
                       bitsPerPixel: bitsPerPixel,
                       bytesPerRow: bytesPerRow,
                       space: CGColorSpaceCreateDeviceGray(),
                       bitmapInfo: bitmapInfo,
                       provider: dataProvider,
                       decode: nil,
                       shouldInterpolate: false,
                       intent: .defaultIntent)!
    }
}

// MARK: - RGB
extension RGB: ConvertibleToCGImage {
    @inlinable
    public static func toCGImage(image: Image<RGB, UInt8>) -> CGImage {
        return image.toRGBA(with: UInt8.max).cgImage()
    }
}

// MARK: - RGBA
extension RGBA: ConvertibleFromCGImage, ConvertibleToCGImage {
    @inlinable
    public static func fromCGImage(cgImage: CGImage) -> Image<RGBA, UInt8> {
        let width = cgImage.width
        let height = cgImage.height
        
        var data = [UInt8](repeating: 0, count: cgImage.bytesPerRow*height)
        let context = CGContext(data: &data,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width*RGBA.channels,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue).rawValue)!
        context.clear(CGRect(x: 0, y: 0, width: width, height: height))
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        var image = Image<RGBA, UInt8>(width: cgImage.width, height: cgImage.height, data: data)
        
        // cancel premultiplication
        image.pixelwiseConvert { px in
            let alpha = Int(px[RGBA.alpha.rawValue])
            if alpha == 0 { return }
            for c in RGBA.allCases {
                px[c.rawValue] = UInt8(255*Int(px[c.rawValue]) / alpha)
            }
        }
        
        return image
    }
    
    @inlinable
    public static func toCGImage(image: Image<RGBA, UInt8>) -> CGImage {
        let bitsPerComponent = MemoryLayout<UInt8>.size * 8
        let bitsPerPixel = RGBA.channels * bitsPerComponent
        let bytesPerRow = image.width * bitsPerPixel / 8
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
            .union(CGBitmapInfo.byteOrder32Big)
        
        let data = image.premultipliedImage().data
        let cfData = CFDataCreate(nil, data, data.count)!
        let dataProvider = CGDataProvider(data: cfData)!
        
        return CGImage(width: image.width,
                       height: image.height,
                       bitsPerComponent: bitsPerComponent,
                       bitsPerPixel: bitsPerPixel,
                       bytesPerRow: bytesPerRow,
                       space: CGColorSpaceCreateDeviceRGB(),
                       bitmapInfo: bitmapInfo,
                       provider: dataProvider,
                       decode: nil,
                       shouldInterpolate: false,
                       intent: .defaultIntent)!
    }
}

extension Image where P == RGBA, T == UInt8 {
    @inlinable
    func premultipliedImage() -> Image<P, T> {
        var newImage = self
        newImage.pixelwiseConvert { px in
            let alpha = Int(px[P.alpha.rawValue])
            for c in [P.red.rawValue, P.green.rawValue, P.blue.rawValue] {
                px[c] = UInt8(Int(px[c]) * alpha / 255)
            }
        }
        return newImage
    }
}

#endif
