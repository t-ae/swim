#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

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
