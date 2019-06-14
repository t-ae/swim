#if canImport(Accelerate)

import Accelerate

extension vImageUtils {
    @inlinable
    public static func withBuffer<P, R>(_ image: inout Image<P, UInt8>,
                                        closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<UInt8>.size * width * P.channels)
            return closure(&buffer)
        }
    }
    
    @inlinable
    public static func withBuffer<P, R>(_ image: inout Image<P, Float>,
                                        closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<Float>.size * width * P.channels)
            return closure(&buffer)
        }
    }
}

#endif
