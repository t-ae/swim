#if canImport(Accelerate)

import Accelerate

// MARK: - Dilate
extension vImageUtils {
    @inlinable
    public static func dilate(src: inout Image<Gray, UInt8>,
                              kernel: Image<Gray, UInt8>) throws -> Image<Gray, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try dilate(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func dilate(src: inout Image<Gray, UInt8>,
                              roi: Rect,
                              kernel: Image<Gray, UInt8>) throws -> Image<Gray, UInt8> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageDilate_Planar8(&src, &dest, UInt(roi.x), UInt(roi.y),
                                                kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
    
    @inlinable
    public static func dilate(src: inout Image<Gray, Float>,
                              kernel: Image<Gray, Float>) throws -> Image<Gray, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try dilate(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func dilate(src: inout Image<Gray, Float>,
                              roi: Rect,
                              kernel: Image<Gray, Float>) throws -> Image<Gray, Float> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageDilate_PlanarF(&src, &dest, UInt(roi.x), UInt(roi.y),
                                                kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
}

// MARK: - Erode
extension vImageUtils {
    @inlinable
    public static func erode(src: inout Image<Gray, UInt8>,
                             kernel: Image<Gray, UInt8>) throws -> Image<Gray, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try erode(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func erode(src: inout Image<Gray, UInt8>,
                             roi: Rect,
                             kernel: Image<Gray, UInt8>) throws -> Image<Gray, UInt8> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageErode_Planar8(&src, &dest, UInt(roi.x), UInt(roi.y),
                                               kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
    
    @inlinable
    public static func erode(src: inout Image<Gray, Float>,
                             kernel: Image<Gray, Float>) throws -> Image<Gray, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try erode(src: &src, roi: roi, kernel: kernel)
    }
    
    @inlinable
    public static func erode(src: inout Image<Gray, Float>,
                             roi: Rect,
                             kernel: Image<Gray, Float>) throws -> Image<Gray, Float> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageErode_PlanarF(&src, &dest, UInt(roi.x), UInt(roi.y),
                                               kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
}

// MARK: - Max
extension vImageUtils {
    @inlinable
    public static func max(src: inout Image<Gray, UInt8>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try max(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func max(src: inout Image<Gray, UInt8>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, UInt8> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageMax_Planar8(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                             UInt(kernelHeight), UInt(kernelWidth), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
    
    @inlinable
    public static func max(src: inout Image<Gray, Float>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try max(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func max(src: inout Image<Gray, Float>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, Float> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageMax_PlanarF(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                             UInt(kernelHeight), UInt(kernelWidth), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
}

// MARK: - Min
extension vImageUtils {
    @inlinable
    public static func min(src: inout Image<Gray, UInt8>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, UInt8> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try min(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func min(src: inout Image<Gray, UInt8>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, UInt8> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageMin_Planar8(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                             UInt(kernelHeight), UInt(kernelWidth), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
    
    @inlinable
    public static func min(src: inout Image<Gray, Float>,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, Float> {
        let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
        return try min(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
    }
    
    @inlinable
    public static func min(src: inout Image<Gray, Float>,
                           roi: Rect,
                           kernelWidth: Int,
                           kernelHeight: Int) throws -> Image<Gray, Float> {
        return try withBuffer(&src) { (src: inout vImage_Buffer) in
            try createWithBuffer(width: roi.width, height: roi.height) { dest in
                let code = vImageMin_PlanarF(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                             UInt(kernelHeight), UInt(kernelWidth), 0)
                
                switch code {
                case kvImageNoError:
                    break
                default:
                    throw vImageUtilsError(vImageErrorCode: code)
                }
            }
        }
    }
}

#endif
