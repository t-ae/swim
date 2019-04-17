#if canImport(Accelerate)

import Accelerate

extension vImageUtils {
    // MARK: UInt8
    @inlinable
    public static func withBuffer<R>(_ image: inout Image<Intensity, UInt8>,
                                     closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<UInt8>.size * width * Intensity.channels)
            return closure(&buffer)
        }
    }
    
    @inlinable
    public static func withBuffer<R>(_ image: inout Image<RGBA, UInt8>,
                                     closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<UInt8>.size * width * RGBA.channels)
            return closure(&buffer)
        }
    }
    
    @inlinable
    public static func withBuffer<R>(_ image: inout Image<ARGB, UInt8>,
                                     closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<UInt8>.size * width * ARGB.channels)
            return closure(&buffer)
        }
    }
    
    // MARK: Float
    @inlinable
    public static func withBuffer<R>(_ image: inout Image<Intensity, Float>,
                                     closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<Float>.size * width * Intensity.channels)
            return closure(&buffer)
        }
    }
    
    @inlinable
    public static func withBuffer<R>(_ image: inout Image<RGBA, Float>,
                                     closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<Float>.size * width * RGBA.channels)
            return closure(&buffer)
        }
    }
    
    @inlinable
    public static func withBuffer<R>(_ image: inout Image<ARGB, Float>,
                                     closure: (inout vImage_Buffer)->R) -> R {
        let height = image.height
        let width = image.width
        return image.data.withUnsafeMutableBufferPointer {
            var buffer = vImage_Buffer(data: $0.baseAddress!,
                                       height: UInt(height),
                                       width: UInt(width),
                                       rowBytes: MemoryLayout<Float>.size * width * ARGB.channels)
            return closure(&buffer)
        }
    }
}

#endif
