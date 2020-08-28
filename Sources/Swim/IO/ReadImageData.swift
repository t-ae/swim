import Foundation
import CStbImage

@inlinable
func readFileData(_ data: Data) throws -> STBImageData {
    let len = Int32(data.count)
    var width: Int32 = 0
    var height: Int32 = 0
    var bpp: Int32 = 0
    
    let pixels = try data.withUnsafeBytes { (p: UnsafeRawBufferPointer) -> UnsafeMutablePointer<stbi_uc> in
        let uc = p.baseAddress!.assumingMemoryBound(to: UInt8.self)
        guard let pixels = stbi_load_from_memory(uc, len, &width, &height, &bpp, 0) else {
            throw ImageReadError.failedToReadImage
        }
        return pixels
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
    /// Read image from memory.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        let imageData = try readFileData(fileData)
        try self.init(stbImageData: imageData)
    }
}

extension Image where P == GrayAlpha, T == UInt8 {
    /// Read image from memory.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        let imageData = try readFileData(fileData)
        try self.init(stbImageData: imageData)
    }
}

extension Image where P == RGB, T == UInt8 {
    /// Read image from memory.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        let imageData = try readFileData(fileData)
        try self.init(stbImageData: imageData)
    }
}

extension Image where P == RGBA, T == UInt8 {
    /// Read image from memory.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        let imageData = try readFileData(fileData)
        try self.init(stbImageData: imageData)
    }
}

// MARK: - BinaryFloatingPoint
extension Image where P == Gray, T: BinaryFloatingPoint {
    /// Read image from memory.
    ///
    /// All pixel values will be in [0, 1] range.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(fileData: fileData))
    }
}

extension Image where P == GrayAlpha, T: BinaryFloatingPoint {
    /// Read image from memory.
    ///
    /// All pixel values will be in [0, 1] range.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(fileData: fileData))
    }
}

extension Image where P == RGB, T: BinaryFloatingPoint {
    /// Read image from memory.
    ///
    /// All pixel values will be in [0, 1] range.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(fileData: fileData))
    }
}

extension Image where P == RGBA, T: BinaryFloatingPoint {
    /// Read image from memory.
    ///
    /// All pixel values will be in [0, 1] range.
    ///
    /// - Parameter fileData: Image data encoded in BMP, PNG, or JPEG format.
    @inlinable
    public init(fileData: Data) throws {
        self = try convertPixelValue(image: Image<P, UInt8>(fileData: fileData))
    }
}
