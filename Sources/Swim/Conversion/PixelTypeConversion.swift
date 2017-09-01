
import Foundation

// MARK: - RGB -> Intensity
extension Image where P == RGB, T: BinaryFloatingPoint {
    func _toBrightness() -> Image<Intensity, T> {
        return _converted { x, y, px in (px[.red] + px[.green] + px[.blue]) / 3 }
    }
    
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    func _toLuminane() -> Image<Intensity, T> {
        return _converted { x, y, px -> T in
            let r = 0.2126*px[.red]
            let g = 0.7152*px[.green]
            let b = 0.0722*px[.blue]
            return r + g + b
        }
    }
    
    public func toLuminane() -> Image<Intensity, T> {
        return _toLuminane()
    }
}

// MARK: - RGB -> RGBWithAlpha
func imageFromRGB<P: RGBWithAlpha, T: DataType>(image: Image<RGB, T>, alpha: T) -> Image<P, T> {
    var newImage = Image<P, T>(width: image.width, height: image.height, value: alpha)
    image.data.withUnsafeBufferPointer {
        var src = $0.baseAddress!
        newImage.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress! + P.redIndex
            for _ in 0..<image.width*image.height {
                memcpy(dst, src, RGB.channels * MemoryLayout<T>.size)
                src += RGB.channels
                dst += P.channels
            }
        }
    }
    
    return newImage
}

extension Image where P: RGBWithAlpha {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
}

// MARK: - RGBWithAlpha -> RGB
func imageFromRGBWithAlpha<P: RGBWithAlpha, T: DataType>(image: Image<P, T>) -> Image<RGB, T> {
    var newImage = Image<RGB, T>(width: image.width, height: image.height)
    image.data.withUnsafeBufferPointer {
        var src = $0.baseAddress! + P.redIndex
        newImage.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<image.width*image.height {
                memcpy(dst, src, RGB.channels)
                dst += RGB.channels
                src += P.channels
            }
        }
    }
    return newImage
}

extension Image where P == RGB {
    public init<P: RGBWithAlpha>(image: Image<P, T>) {
        self = imageFromRGBWithAlpha(image: image)
    }
}
