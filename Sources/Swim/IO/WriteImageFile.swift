import Foundation
import CStbImage

// MARK: Protocol
public protocol ImageFileFormat {}
public protocol AlphaImageFileFormat {}

extension Gray: ImageFileFormat {}
extension RGB: ImageFileFormat {}
extension GrayAlpha: AlphaImageFileFormat {}
extension RGBA: AlphaImageFileFormat {}

// MARK: - WriteFormat

public enum WriteFormat {
    case bitmap, jpeg(quality: Int), png
}

// MARK: - Utilities
@inlinable
func write<P: AlphaImageFileFormat>(image: Image<P, UInt8>, url: URL) throws {
    guard url.isFileURL else {
        throw ImageWriteError.failedToWrite
    }
    
    let path = url.path
    
    let width = Int32(image.width)
    let height = Int32(image.height)
    let bpp = Int32(P.channels)
    
    let code = image.data.withUnsafeBufferPointer {
        write_image_png(path, width, height, bpp, $0.baseAddress!)
    }
    
    guard code != 0 else {
        throw ImageWriteError.failedToWrite
    }
}

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
        code = image.data.withUnsafeBufferPointer {
            write_image_bmp(path, width, height, bpp, $0.baseAddress!)
        }
    case let .jpeg(quality):
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
extension Image where P: AlphaImageFileFormat, T == UInt8 {
    /// Writes representation of the image to a URL using the PNG format.
    @inlinable
    public func write(to url: URL) throws {
        try Swim.write(image: self, url: url)
    }
}

extension Image where P: ImageFileFormat, T == UInt8 {
    /// Writes representation of the image to a URL using the format detected from the URL extension.
    ///
    /// File format is automatically decided from pathExtension of url.
    @inlinable
    public func write(to url: URL) throws {
        let format = detectFormat(url: url)
        try write(to: url, format: format)
    }
    
    /// Writes representation of the image to a URL using the specified format.
    ///
    /// - Parameter format: Image file format. Defaults to PNG.
    @inlinable
    public func write(to url: URL, format: WriteFormat = .png) throws {
        try Swim.write(image: self, url: url, format: format)
    }
}

// MARK: - FloatingPoint
extension Image where P: AlphaImageFileFormat, T: BinaryFloatingPoint {
    /// Writes representation of the image to a URL using the PNG format.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public func write(to url: URL) throws {
        return try convertPixelValue(image: self).write(to: url)
    }
}

extension Image where P: ImageFileFormat, T: BinaryFloatingPoint {
    /// Writes representation of the image to a URL using the format detected from the URL extension.
    ///
    /// File format is automatically decided from pathExtension of url.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public func write(to url: URL) throws {
        let format = detectFormat(url: url)
        try write(to: url, format: format)
    }
    
    /// Writes representation of the image to a URL using the specified format.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    ///
    /// - Parameter format: Image file format. Defaults to PNG.
    @inlinable
    public func write(to url: URL, format: WriteFormat = .png) throws {
        return try convertPixelValue(image: self).write(to: url, format: format)
    }
}
