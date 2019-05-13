import Foundation

extension Blender {
    @inlinable
    public static func additiveBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        for i in 0..<bottom.data.count {
            bottom.data[i] = min(top.data[i] + bottom.data[i], 1)
        }
    }
    
    @inlinable
    public static func additiveBlend<P: RGBWithAlpha, T: FloatingPoint>(top: Image<P, T>,
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
                        dst.pointee = dst.pointee * (1 - srcAlpha.pointee) + min(dst.pointee + srcColor.pointee, 1) * srcAlpha.pointee
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
