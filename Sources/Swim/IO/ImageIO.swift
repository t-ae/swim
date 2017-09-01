
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
    public init?(path: String) {
        
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
    public init?(path: String) {
        
        var width: Int32 = 0
        var height: Int32 = 0
        var bpp: Int32 = 0
        
        guard let pixels = load_image_float(path, &width, &height, &bpp, Int32(P.channels)) else {
            return nil
        }
        defer { free_image(pixels) }
        
        guard bpp == Int32(P.channels) else {
            return nil
        }
        
        let data = [Float](UnsafeBufferPointer(start: pixels, count: Int(width*height)*P.channels))
        
        self.init(width: Int(width), height: Int(height), data: data)
    }
}

// MARK: Write
private func write<P, T>(image: Image<P, T>, path: String, type: ImageFileType) throws {
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
    public func write(path: String, type: ImageFileType) throws {
        try Swim.write(image: self, path: path, type: type)
    }
}

extension Image where P == RGBA, T == UInt8 {
    public func write(path: String, type: ImageFileType) throws {
        switch type {
        case .bitmap, .jpeg:
            throw ImageWriteError.alphaNotSupported
        default:
            try Swim.write(image: self, path: path, type: type)
        }
        
    }
}
