import Foundation
import CStbImage

// MARK: - Utilities
@usableFromInline
struct STBImageData {
    @usableFromInline var width: Int
    @usableFromInline var height: Int
    @usableFromInline var bpp: Int
    @usableFromInline var data: [UInt8]
    
    @inlinable
    init(width: Int, height: Int, bpp: Int, data: [UInt8]) {
        self.width = width
        self.height = height
        self.bpp = bpp
        self.data = data
    }
}

@inlinable
func readImage(url: URL) throws -> STBImageData {
    guard FileManager.default.fileExists(atPath: url.path) else {
        throw ImageReadError.fileNotFound
    }
    
    var width: Int32 = 0
    var height: Int32 = 0
    var bpp: Int32 = 0
    
    guard let pixels = load_image(url.path, &width, &height, &bpp, 0) else {
        throw ImageReadError.failedToReadImage
    }
    defer { free_image(pixels) }
    
    let data = [UInt8](UnsafeBufferPointer(start: pixels, count: Int(width*height*bpp)))
    
    return STBImageData(width: Int(width),
                        height: Int(height),
                        bpp: Int(bpp),
                        data: data)
}

// MARK: - UInt8

extension Image where P == Intensity, T == UInt8 {
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        
        guard imageData.bpp == 1 else {
            throw ImageReadError.pixelTypeMismatch(detectedChannels: imageData.bpp)
        }
        
        self.init(width: imageData.width, height: imageData.height, data: imageData.data)
    }
}

extension Image where P == IntensityAlpha, T == UInt8 {
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        
        switch imageData.bpp {
        case 1:
            let intensity = Image<Intensity, UInt8>(width: imageData.width,
                                                    height: imageData.height,
                                                    data: imageData.data)
            self.init(image: intensity, alpha: UInt8.max)
        case 2:
            self.init(width: imageData.width, height: imageData.height, data: imageData.data)
        default:
            throw ImageReadError.pixelTypeMismatch(detectedChannels: imageData.bpp)
        }
    }
}

extension Image where P == RGB, T == UInt8 {
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        
        switch imageData.bpp {
        case 1:
            let intensity = Image<Intensity, UInt8>(width: imageData.width,
                                                    height: imageData.height,
                                                    data: imageData.data)
            self = intensity.toRGB()
        case 3:
            self.init(width: imageData.width, height: imageData.height, data: imageData.data)
        default:
            throw ImageReadError.pixelTypeMismatch(detectedChannels: imageData.bpp)
        }
    }
}

extension Image where P == RGBA, T == UInt8 {
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        
        switch imageData.bpp {
        case 1:
            let intensity = Image<Intensity, UInt8>(width: imageData.width,
                                                    height: imageData.height,
                                                    data: imageData.data)
            self.init(image: intensity.toRGB(), alpha: UInt8.max)
        case 2:
            let ia = Image<IntensityAlpha, UInt8>(width: imageData.width,
                                                  height: imageData.height,
                                                  data: imageData.data)
            self.init(r: ia[channel: .intensity],
                      g: ia[channel: .intensity],
                      b: ia[channel: .intensity],
                      a: ia[channel: .alpha])
        case 3:
            let rgb = Image<RGB, UInt8>(width: imageData.width,
                                        height: imageData.height,
                                        data: imageData.data)
            self.init(image: rgb, alpha: UInt8.max)
        case 4:
            self.init(width: imageData.width, height: imageData.height, data: imageData.data)
        default:
            throw ImageReadError.pixelTypeMismatch(detectedChannels: imageData.bpp)
        }
    }
}

// MARK: - Float

extension Image where P == Intensity, T == Float {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P == IntensityAlpha, T == Float {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P == RGB, T == Float {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P == RGBA, T == Float {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

// MARK: - Double
extension Image where P == Intensity, T == Double {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P == IntensityAlpha, T == Double {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P == RGB, T == Double {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P == RGBA, T == Double {
    @inlinable
    public init(contentsOf url: URL) throws {
        let uint8 = try Image<P, UInt8>(contentsOf: url)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

// MARK: - Error type

public enum ImageReadError: Error {
    case fileNotFound
    case failedToReadImage
    case pixelTypeMismatch(detectedChannels: Int)
}
