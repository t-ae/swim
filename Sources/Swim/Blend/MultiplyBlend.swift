import Foundation

extension Blender {
    @inlinable
    public static func multiplyBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        bottom *= top
    }
    
    @inlinable
    public static func multiplyBlend<P: RGBWithAlpha, T: FloatingPoint>(top: Image<P, T>,
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
                        // dst * (1 - srcAlpha) + dst * src * srcAlpha
                        dst.pointee *= 1 - srcAlpha.pointee + srcColor.pointee * srcAlpha.pointee
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
