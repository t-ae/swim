#if canImport(Accelerate)

import Accelerate

public protocol vImagePixelType: PixelType {}
extension Gray: vImagePixelType {}
extension ARGB: vImagePixelType {}

public protocol vImageDataType: DataType {}
extension UInt8: vImageDataType {}
extension Float: vImageDataType {}

extension vImageUtils {
    @inlinable
    public static func withBuffer<P: vImagePixelType, T: vImageDataType, R>(image: inout Image<P, T>, closure: (inout vImage_Buffer) throws -> R) rethrows -> R {
        
        let height = image.height
        let width = image.width
        return try image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<T>.size * width * P.channels)
            return try closure(&buffer)
        }
    }
    
    @inlinable
    public static func createImageWithBuffer<P: vImagePixelType, T: vImageDataType>(width: Int, height: Int, body: (inout vImage_Buffer) throws -> Void) rethrows -> Image<P, T> {
        
        return try .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<T>.size * width * P.channels)
            try body(&buffer)
        }
    }
}

#endif
