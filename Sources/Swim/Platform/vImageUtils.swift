#if canImport(Accelerate)

import Accelerate

public enum vImageUtils {
}

public struct vImageUtilsError: Error {
    public let vImageErrorCode: Int
    
    @inlinable
    init(vImageErrorCode: Int) {
        self.vImageErrorCode = vImageErrorCode
    }
}

// MARK: - vImage_Buffer
extension vImageUtils{
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
                                     closure: (inout vImage_Buffer)->R) -> R{
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
                                     closure: (inout vImage_Buffer)->R) -> R{
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
                                     closure: (inout vImage_Buffer)->R) -> R{
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
                                     closure: (inout vImage_Buffer)->R) -> R{
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

// MARK: - AlphaBlend
extension vImageUtils{
    // MARK: UInt8
    @inlinable
    public static func alphaBlend(top: inout Image<ARGB, UInt8>,
                                  bottom: inout Image<ARGB, UInt8>) throws -> Image<ARGB, UInt8> {
        precondition(top.width == bottom.width && top.height == bottom.height)
        
        let width = top.width
        let height = top.height
        
        var memory = [UInt8](repeating: 0, count: width*height*ARGB.channels)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(height),
                                 width: UInt(width),
                                 rowBytes: MemoryLayout<UInt8>.size*width)
        
        let code = withBuffer(&top) { (srcTop: inout vImage_Buffer) in
            withBuffer(&bottom) { (srcBottom: inout vImage_Buffer) in
                vImageAlphaBlend_ARGB8888(&srcTop, &srcBottom, &dest, 0)
            }
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: width, height: height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
    
    // MARK: Float
    @inlinable
    public static func alphaBlend(top: inout Image<ARGB, Float>,
                                  bottom: inout Image<ARGB, Float>) throws -> Image<ARGB, Float> {
        precondition(top.width == bottom.width && top.height == bottom.height)
        
        let width = top.width
        let height = top.height
        
        var memory = [Float](repeating: 0, count: width*height*ARGB.channels)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(height),
                                 width: UInt(width),
                                 rowBytes: MemoryLayout<Float>.size*width)
        
        let code = withBuffer(&top) { (srcTop: inout vImage_Buffer) in
            withBuffer(&bottom) { (srcBottom: inout vImage_Buffer) in
                vImageAlphaBlend_ARGBFFFF(&srcTop, &srcBottom, &dest, 0)
            }
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: width, height: height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
}

// MARK: - Dilate
extension vImageUtils {
    // MARK: UInt8
    @inlinable
    public static func dilate(src: inout Image<Intensity, UInt8>,
                              kernel: Image<Intensity, UInt8>) throws -> Image<Intensity, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try dilate(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func dilate(src: inout Image<Intensity, UInt8>,
                              roi: Rect,
                              kernel: Image<Intensity, UInt8>) throws -> Image<Intensity, UInt8> {
        
        var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<UInt8>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageDilate_Planar8(&src, &dest, UInt(roi.x), UInt(roi.y),
                                 kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
    
    // MARK: Float
    @inlinable
    public static func dilate(src: inout Image<Intensity, Float>,
                              kernel: Image<Intensity, Float>) throws -> Image<Intensity, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try dilate(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func dilate(src: inout Image<Intensity, Float>,
                              roi: Rect,
                              kernel: Image<Intensity, Float>) throws -> Image<Intensity, Float> {
        
        var memory = [Float](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<Float>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageDilate_PlanarF(&src, &dest, UInt(roi.x), UInt(roi.y),
                                 kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
}

// MARK: - Erode
extension vImageUtils {
    // MARK: UInt8
    @inlinable
    public static func erode(src: inout Image<Intensity, UInt8>,
                             kernel: Image<Intensity, UInt8>) throws -> Image<Intensity, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try erode(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func erode(src: inout Image<Intensity, UInt8>,
                             roi: Rect,
                             kernel: Image<Intensity, UInt8>) throws -> Image<Intensity, UInt8> {
        
        var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<UInt8>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageErode_Planar8(&src, &dest, UInt(roi.x), UInt(roi.y),
                                kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
    
    // MARK: Float
    @inlinable
    public static func erode(src: inout Image<Intensity, Float>,
                             kernel: Image<Intensity, Float>) throws -> Image<Intensity, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try erode(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func erode(src: inout Image<Intensity, Float>,
                             roi: Rect,
                             kernel: Image<Intensity, Float>) throws -> Image<Intensity, Float> {
        
        var memory = [Float](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<Float>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageErode_PlanarF(&src, &dest, UInt(roi.x), UInt(roi.y),
                                kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
}

// MARK: - Max
extension vImageUtils {
    // MARK: UInt8
    @inlinable
    public static func max(src: inout Image<Intensity, UInt8>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try max(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func max(src: inout Image<Intensity, UInt8>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, UInt8> {
        
        var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<UInt8>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageMax_Planar8(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                              UInt(kernelHeight), UInt(kernelWidth), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
    
    // MARK: Float
    @inlinable
    public static func max(src: inout Image<Intensity, Float>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try max(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func max(src: inout Image<Intensity, Float>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, Float> {
        
        var memory = [Float](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<Float>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageMax_PlanarF(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                              UInt(kernelHeight), UInt(kernelWidth), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
}

// MARK: - Min
extension vImageUtils {
    // MARK: UInt8
    @inlinable
    public static func min(src: inout Image<Intensity, UInt8>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try min(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func min(src: inout Image<Intensity, UInt8>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, UInt8> {
        
        var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<UInt8>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageMin_Planar8(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                              UInt(kernelHeight), UInt(kernelWidth), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
    
    // MARK: Float
    @inlinable
    public static func min(src: inout Image<Intensity, Float>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try min(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func min(src: inout Image<Intensity, Float>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Intensity, Float> {
        
        var memory = [Float](repeating: 0, count: roi.width * roi.height)
        var dest = vImage_Buffer(data: &memory,
                                 height: UInt(roi.height),
                                 width: UInt(roi.width),
                                 rowBytes: MemoryLayout<Float>.size*roi.width)
        
        let code = withBuffer(&src) { (src: inout vImage_Buffer) in
            vImageMin_PlanarF(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                              UInt(kernelHeight), UInt(kernelWidth), 0)
        }
        
        switch code {
        case kvImageNoError:
            return Image(width: roi.width, height: roi.height, data: memory)
        default:
            throw vImageUtilsError(vImageErrorCode: code)
        }
    }
}

#endif
