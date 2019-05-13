import Foundation

extension Blender {
    @inlinable
    public static func screenBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        for i in 0..<bottom.data.count {
            // 1 - (1-a)(1-b)
            bottom.data[i] = 1 - (1-bottom.data[i]) * (1-top.data[i])
        }
    }
    
    @inlinable
    public static func screenBlend<P: RGBWithAlpha, T: FloatingPoint>(
        top: Image<P, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        var redIndex = P.redIndex
        var alphaIndex = P.alphaIndex
        var bottomIndex = 0
        for _ in 0..<bottom.width*bottom.height {
            let topAlpha = top.data[alphaIndex]
            
            if topAlpha > 0 {
                for i in 0..<RGB.channels {
                    // dst * (1 - srcAlpha) + (1 - (1 - srcColor)*(1 - dst))*srcAlpha
                    bottom.data[bottomIndex+i] *= 1 - top.data[redIndex+i] * topAlpha
                    bottom.data[bottomIndex+i] += top.data[redIndex+i] * topAlpha
                }
            }
            
            redIndex += P.channels
            alphaIndex += P.channels
            bottomIndex += RGB.channels
        }
    }
}
