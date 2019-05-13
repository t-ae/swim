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
    public static func additiveBlend<P: RGBWithAlpha, T: FloatingPoint>(
        top: Image<P, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        var redIndex = P.redIndex
        var alphaIndex = P.alphaIndex
        var bottomIndex = 0
        for _ in 0..<bottom.width*bottom.height {
            let topAlpha = top.data[alphaIndex]
            
            if topAlpha > 0 {
                for i in 0..<RGB.channels {
                    let blend = min(bottom.data[bottomIndex+i] + top.data[redIndex+i], 1)
                    bottom.data[bottomIndex+i] *= (1 - topAlpha)
                    bottom.data[bottomIndex+i] += blend * topAlpha
                }
            }
            
            redIndex += P.channels
            alphaIndex += P.channels
            bottomIndex += RGB.channels
        }
    }
}
