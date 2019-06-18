#if canImport(Accelerate)

import Accelerate

public protocol vImagePixelType: PixelType {}
extension Gray: vImagePixelType {}
extension RGB: vImagePixelType {}
extension RGBA: vImagePixelType {}
extension ARGB: vImagePixelType {}

public protocol vImageDataType: DataType {}
extension UInt8: vImageDataType {}
extension Float: vImageDataType {}

extension vImageUtils {
    /// Create `vImage_Buffer` pointing `image` and execute `body`.
    ///
    /// `vImage_Buffer` is interleaved format.
    @inlinable
    public static func withBuffer<P: vImagePixelType, T: vImageDataType, R>(image: inout Image<P, T>, body: (inout vImage_Buffer) throws -> R) rethrows -> R {
        
        let height = image.height
        let width = image.width
        return try image.data.withUnsafeMutableBufferPointer { bp in
            var buffer = vImage_Buffer(data: bp.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<T>.size * width * P.channels)
            defer {
                // Check if vImage_Buffer itself is not replaced while closure execution
                precondition(buffer.data == UnsafeMutableRawPointer(bp.baseAddress), "Replacing `vImage_Buffer` is not allowed.")
                precondition(buffer.width == UInt(width), "Replacing `vImage_Buffer` is not allowed.")
                precondition(buffer.height == UInt(height), "Replacing `vImage_Buffer` is not allowed.")
                precondition(buffer.rowBytes == MemoryLayout<T>.size * width * P.channels, "Replacing `vImage_Buffer` is not allowed.")
            }
            
            return try body(&buffer)
        }
    }
    
    /// Execute `body` with uninitialized `vImage_Buffer`. Then create `Image<P, T>` with it.
    ///
    /// `vImage_Buffer` must be interleaved format.
    @inlinable
    public static func createImageWithBuffer<P: vImagePixelType, T: vImageDataType>(width: Int, height: Int, body: (inout vImage_Buffer) throws -> Void) rethrows -> Image<P, T> {
        
        return try .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<T>.size * width * P.channels)
            try body(&buffer)
            
            // Check if vImage_Buffer itself is not replaced while closure execution
            precondition(buffer.data == UnsafeMutableRawPointer($0.baseAddress), "Replacing `vImage_Buffer` is not allowed.")
            precondition(buffer.width == UInt(width), "Replacing `vImage_Buffer` is not allowed.")
            precondition(buffer.height == UInt(height), "Replacing `vImage_Buffer` is not allowed.")
            precondition(buffer.rowBytes == MemoryLayout<T>.size * width * P.channels, "Replacing `vImage_Buffer` is not allowed.")
        }
    }
}

#endif
