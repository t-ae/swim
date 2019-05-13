import Foundation

extension Blender {
    @inlinable
    public static func screenBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        for i in 0..<bottom.data.count {
            // 1 - (1-a)(1-b)
            bottom.data[i] = (1-bottom.data[i]) * (1-top.data[i])
        }
    }
    
    @inlinable
    public static func screenBlend<P: RGBWithAlpha, T: FloatingPoint>(top: Image<P, T>,
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
                        // dst * (1 - srcAlpha) * (1 - (1 - srcColor)*(1 - dst))*srcAlpha
                        dst.pointee *= 1 - srcColor.pointee * srcAlpha.pointee
                        dst.pointee += srcColor.pointee * srcAlpha.pointee
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
