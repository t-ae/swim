import Foundation
import CStbImage

// MAKR: WriteFormat

public enum WriteFormat {
    case bitmap, jpeg(quality: Int), png
}

// MARK: - Utilities

@inlinable
func write<P: ImageFileFormat>(image: Image<P, UInt8>, url: URL, format: WriteFormat) throws {
    
    guard url.isFileURL else {
        throw ImageWriteError.failedToWrite
    }
    
    let path = url.path
    
    let width = Int32(image.width)
    let height = Int32(image.height)
    let bpp = Int32(P.channels)
    
    let code: Int32
    switch format {
    case .bitmap:
        guard !(image is HasAlpha) else {
            throw ImageWriteError.alphaNotSupported
        }
        code = image.data.withUnsafeBufferPointer {
            write_image_bmp(path, width, height, bpp, $0.baseAddress!)
        }
    case let .jpeg(quality):
        guard !(image is HasAlpha) else {
            throw ImageWriteError.alphaNotSupported
        }
        guard (1...100).contains(quality) else {
            throw ImageWriteError.qualityOutOfRange
        }
        code = image.data.withUnsafeBufferPointer {
            write_image_jpg(path, width, height, bpp, $0.baseAddress!, Int32(quality))
        }
    case .png:
        code = image.data.withUnsafeBufferPointer {
            write_image_png(path, width, height, bpp, $0.baseAddress!)
        }
    }
    
    guard code != 0 else {
        throw ImageWriteError.failedToWrite
    }
}

@inlinable
func detectFormat(url: URL) -> WriteFormat {
    switch url.pathExtension.lowercased() {
    case "bmp":
        return .bitmap
    case "jpg", "jpeg":
        return .jpeg(quality: 90)
    default:
        return .png
    }
}

// MARK: - UInt8
extension Image where P: ImageFileFormat, T == UInt8 {
    /// Save image.
    @inlinable
    public func write(to url: URL) throws {
        let format = detectFormat(url: url)
        try write(to: url, format: format)
    }
    
    /// Save image.
    @inlinable
    public func write(to url: URL, format: WriteFormat) throws {
        try Swim.write(image: self, url: url, format: format)
    }
}

// MARK: - FloatingPoint
extension Image where P: ImageFileFormat, T: BinaryFloatingPoint {
    /// Save image.
    ///
    /// Pixel values are clipped to [0, 1].
    @inlinable
    public func write(to url: URL) throws {
        let format = detectFormat(url: url)
        try write(to: url, format: format)
    }
    
    /// Save image.
    ///
    /// Pixel values are clipped to [0, 1].
    @inlinable
    public func write(to url: URL, format: WriteFormat) throws {
        var i255 = self.clipped(low: 0, high: 1) * 255
        i255.round()
        let uint8 = Image<P, UInt8>(cast: i255)
        try uint8.write(to: url, format: format)
    }
}

// MARK: - Error type

public enum ImageWriteError: Error {
    case alphaNotSupported
    case failedToWrite
    case qualityOutOfRange
}
