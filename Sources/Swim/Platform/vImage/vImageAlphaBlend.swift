#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

extension vImageUtils {
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

#endif
