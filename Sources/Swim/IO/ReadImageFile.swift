import Foundation
import CStbImage

@inlinable
func readImage(url: URL) throws -> STBImageData {
    guard FileManager.default.fileExists(atPath: url.path) else {
        throw ImageReadError.fileNotFound
    }
    
    var width: Int32 = 0
    var height: Int32 = 0
    var bpp: Int32 = 0
    
    guard let pixels = stbi_load(url.path, &width, &height, &bpp, 0) else {
        throw ImageReadError.failedToReadImage
    }
    defer { stbi_image_free(pixels) }
    
    let data = [UInt8](UnsafeBufferPointer(start: pixels, count: Int(width*height*bpp)))
    
    return STBImageData(width: Int(width),
                        height: Int(height),
                        bpp: Int(bpp),
                        data: data)
}

// MARK: - UInt8

extension Image where P == Gray, T == UInt8 {
    /// Read image from file.
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        try self.init(stbImageData: imageData)
    }
}

extension Image where P == GrayAlpha, T == UInt8 {
    /// Read image from file.
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        try self.init(stbImageData: imageData)
    }
}

extension Image where P == RGB, T == UInt8 {
    /// Read image from file.
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        try self.init(stbImageData: imageData)
    }
}

extension Image where P == RGBA, T == UInt8 {
    /// Read image from file.
    @inlinable
    public init(contentsOf url: URL) throws {
        let imageData = try readImage(url: url)
        try self.init(stbImageData: imageData)
    }
}

// MARK: - BinaryFloatingPoint
extension Image where P == Gray, T: BinaryFloatingPoint {
    /// Read image from file.
    ///
    /// All pixel values will be in [0, 1] range.
    @inlinable
    public init(contentsOf url: URL) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(contentsOf: url))
    }
}

extension Image where P == GrayAlpha, T: BinaryFloatingPoint {
    /// Read image from file.
    ///
    /// All pixel values will be in [0, 1] range.
    @inlinable
    public init(contentsOf url: URL) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(contentsOf: url))
    }
}

extension Image where P == RGB, T: BinaryFloatingPoint {
    /// Read image from file.
    ///
    /// All pixel values will be in [0, 1] range.
    @inlinable
    public init(contentsOf url: URL) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(contentsOf: url))
    }
}

extension Image where P == RGBA, T: BinaryFloatingPoint {
    /// Read image from file.
    ///
    /// All pixel values will be in [0, 1] range.
    @inlinable
    public init(contentsOf url: URL) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(contentsOf: url))
    }
}
