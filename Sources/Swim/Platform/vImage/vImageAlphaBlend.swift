#if canImport(Accelerate) 

import Accelerate

extension vImageUtils {
    @inlinable
    public static func alphaBlend(top: inout Image<ARGB, UInt8>,
                                  bottom: inout Image<ARGB, UInt8>) throws -> Image<ARGB, UInt8> {
        precondition(top.size == bottom.size)
        
        let (width, height) = top.size
        
        return try withBuffer(image: &top) { (srcTop: inout vImage_Buffer) in
            try withBuffer(image: &bottom) { (srcBottom: inout vImage_Buffer) in
                try createImageWithBuffer(width: width, height: height) { dest in
                    let code = vImageAlphaBlend_ARGB8888(&srcTop, &srcBottom, &dest, 0)
                    
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
    
    @inlinable
    public static func alphaBlend(top: inout Image<ARGB, Float>,
                                  bottom: inout Image<ARGB, Float>) throws -> Image<ARGB, Float> {
        precondition(top.size == bottom.size)
        
        let (width, height) = top.size
        
        return try withBuffer(image: &top) { (srcTop: inout vImage_Buffer) in
            try withBuffer(image: &bottom) { (srcBottom: inout vImage_Buffer) in
                try createImageWithBuffer(width: width, height: height) { dest in
                    let code = vImageAlphaBlend_ARGBFFFF(&srcTop, &srcBottom, &dest, 0)
                    
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
}

#endif
