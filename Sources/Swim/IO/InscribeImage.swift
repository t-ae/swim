import Foundation
import CStbImage

// MARK: Utilities
@inlinable
func inscribe<P: AlphaImageFileFormat>(image: Image<P, UInt8>) throws -> Data {
    let width = Int32(image.width)
    let height = Int32(image.height)
    let bpp = Int32(P.channels)

    var content = Data()
    
    let code = image.data.withUnsafeBufferPointer {
        write_image_png_to_func(inscribe, &content, width, height, bpp, $0.baseAddress!)
    }

    guard code != 0 else {
        throw ImageWriteError.failedToWrite
    }
    
    return content
}

@inlinable
func inscribe<P: ImageFileFormat>(image: Image<P, UInt8>, format: WriteFormat) throws -> Data {
    let width = Int32(image.width)
    let height = Int32(image.height)
    let bpp = Int32(P.channels)
    
    var content = Data()

    let code: Int32
    switch format {
    case .bitmap:
        code = image.data.withUnsafeBufferPointer {
            write_image_bmp_to_func(inscribe, &content, width, height, bpp, $0.baseAddress!)
        }
    case let .jpeg(quality):
        guard (1...100).contains(quality) else {
            throw ImageWriteError.qualityOutOfRange
        }
        code = image.data.withUnsafeBufferPointer {
            write_image_jpg_to_func(inscribe, &content, width, height, bpp, $0.baseAddress!, Int32(quality))
        }
    case .png:
        code = image.data.withUnsafeBufferPointer {
            write_image_png_to_func(inscribe, &content, width, height, bpp, $0.baseAddress!)
        }
    }
    
    guard code != 0 else {
        throw ImageWriteError.failedToWrite
    }
    
    return content
}

@inlinable
func inscribe(context: UnsafeMutableRawPointer?, data: UnsafeMutableRawPointer?, size: Int32) -> Void {
    guard data != nil &&  context != nil else { return }

    let chunk = Data(bytes: data!, count: Int(size))

    let content = context!.assumingMemoryBound(to: Data.self)
    content.pointee.append(chunk)
}

// MARK: - UInt8
extension Image where P: AlphaImageFileFormat, T == UInt8 {
    /// Returns a `Data` containing representation of the image encoded in PNG format.
    @inlinable
    public func inscribe() throws -> Data {
        try Swim.inscribe(image: self)
    }
}

extension Image where P: ImageFileFormat, T == UInt8 {
    /// Returns a `Data` containing representation of the image encoded in the specified format.
    ///
    /// - Parameter format: Image data format. Defaults to PNG.
    @inlinable
    public func inscribe(format: WriteFormat = .png) throws -> Data {
        try Swim.inscribe(image: self, format: format)
    }
}

// MARK: - FloatingPoint
extension Image where P: AlphaImageFileFormat, T: BinaryFloatingPoint {
    /// Returns a `Data` containing representation of the image encoded in PNG format.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public func inscribe() throws -> Data {
        return try convertPixelValue(image: self).inscribe()
    }
}

extension Image where P: ImageFileFormat, T: BinaryFloatingPoint {
    /// Returns a `Data` containing representation of the image encoded in the specified format.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    ///
    /// - Parameter format: Image data format. Defaults to PNG.
    @inlinable
    public func inscribe(format: WriteFormat = .png) throws -> Data {
        return try convertPixelValue(image: self).inscribe(format: format)
    }
}
