
import Foundation
import CStbImage

// MARK: Type
public protocol ImageFileFormat {
    
}

extension Intensity: ImageFileFormat {}
extension IntensityAlpha: ImageFileFormat {}
extension RGB: ImageFileFormat {}
extension RGBA: ImageFileFormat {}

public enum ImageFileType {
    case bitmap, jpeg, png
}

public enum ImageWriteError: Error {
    case alphaNotSupported
    case failedToWrite
}

// MARK: Read
extension Image where P: ImageFileFormat, T == UInt8 {
    public init?(contentsOf url: URL) {
        
        guard url.isFileURL else {
            return nil
        }
        let path = url.path
        
        var width: Int32 = 0
        var height: Int32 = 0
        var bpp: Int32 = 0

        guard let pixels = load_image(path, &width, &height, &bpp, Int32(P.channels)) else {
            return nil
        }
        defer { free_image(pixels) }
        
        guard bpp == Int32(P.channels) else {
            return nil
        }
        
        let data = [UInt8](UnsafeBufferPointer(start: pixels, count: Int(width*height)*P.channels))
        
        self.init(width: Int(width), height: Int(height), data: data)
    }
}

extension Image where P: ImageFileFormat, T == Float {
    /// Load image file.
    /// All values are in [0, 1].
    public init?(contentsOf url: URL) {
        guard let image = Image<P, UInt8>(contentsOf: url) else {
            return nil
        }
        self = image.typeConverted() / 255
    }
}

extension Image where P: ImageFileFormat, T == Double {
    /// Load image file.
    /// All values are in [0, 1].
    public init?(contentsOf url: URL) {
        guard let image = Image<P, UInt8>(contentsOf: url) else {
            return nil
        }
        self = image.typeConverted() / 255
    }
}

// MARK: Write
private func write<P>(image: Image<P, UInt8>, url: URL, type: ImageFileType) throws {
    
    guard url.isFileURL else {
        throw ImageWriteError.failedToWrite
    }
    
    let path = url.path
    
    let width = Int32(image.width)
    let height = Int32(image.height)
    let bpp = Int32(P.channels)
    
    let code: Int32
    switch type {
    case .bitmap:
        code = image.data.withUnsafeBufferPointer {
            write_image_bmp(path, width, height, bpp, $0.baseAddress!)
        }
    case .jpeg:
        code = image.data.withUnsafeBufferPointer {
            write_image_jpg(path, width, height, bpp, $0.baseAddress!)
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

extension Image where P: ImageFileFormat, T == UInt8 {
    /// Save image.
    public func write(to url: URL, type: ImageFileType) throws {
        try Swim.write(image: self, url: url, type: type)
    }
}

extension Image where P == RGBA, T == UInt8 {
    /// Save image.
    public func write(to url: URL, type: ImageFileType) throws {
        switch type {
        case .bitmap, .jpeg:
            throw ImageWriteError.alphaNotSupported
        default:
            try Swim.write(image: self, url: url, type: type)
        }
    }
}

extension Image where P: ImageFileFormat, T == Float {
    /// Save image.
    /// Pixel values are clipped to [0, 1].
    public func write(to url: URL, type: ImageFileType) throws {
        let i255 = self.clipped(low: 0, high: 1) * 255
        let uint8 = i255.rounded().typeConverted(to: UInt8.self)
        try Swim.write(image: uint8, url: url, type: type)
    }
}

extension Image where P: ImageFileFormat, T == Double {
    /// Save image.
    /// Pixel values are clipped to [0, 1].
    public func write(to url: URL, type: ImageFileType) throws {
        let i255 = self.clipped(low: 0, high: 1) * 255
        let uint8 = i255.rounded().typeConverted(to: UInt8.self)
        try Swim.write(image: uint8, url: url, type: type)
    }
}
