import Foundation

extension Blender {
    @inlinable
    public static func overlayBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    if src.pointee*2 < 1 {
                        dst.pointee *= src.pointee
                    } else {
                        // 1 - 2*(1-a)*(1-b)
                        dst.pointee = (1 - src.pointee) * (1 - dst.pointee)
                        dst.pointee = 1 - 2 * dst.pointee
                    }
                    
                    src += 1
                    dst += 1
                }
            }
        }
    }
    
    @inlinable
    public static func overlayBlend<P: RGBWithAlpha, T: FloatingPoint>(top: Image<P, T>,
                                                                       bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        let (width, height) = top.size
        
        top.data.withUnsafeBufferPointer {
            var srcColor = $0.baseAddress! + P.redIndex
            var srcAlpha = $0.baseAddress! + P.alphaIndex
            bottom.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<width*height {
                    for _ in 0..<RGB.channels {
                        if srcColor.pointee*2 < 1 {
                            // dst * (1 - srcAlpha) + 2 * dst * src * srcAlpha
                            dst.pointee *= 1 - srcAlpha.pointee + 2 * srcColor.pointee * srcAlpha.pointee
                        } else {
                            // dst * (1 - srcAlpha) * (1 - 2*(1-srcColor)*(1-dst))*srcAlpha
                            var s = (1 - srcColor.pointee) * (1 - dst.pointee)
                            s = 1 - 2 * s
                            dst.pointee *= 1 - srcAlpha.pointee
                            dst.pointee += s * srcAlpha.pointee
                        }
                        srcColor += 1
                        dst += 1
                    }
                    
                    srcColor += P.channels - RGB.channels
                    srcAlpha += P.channels
                }
            }
        }
    }
}
