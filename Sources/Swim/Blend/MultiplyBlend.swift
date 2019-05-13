import Foundation

extension Blender {
    @inlinable
    public static func multiplyBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        bottom *= top
    }
    
    @inlinable
    public static func multiplyBlend<P: RGBWithAlpha, T: FloatingPoint>(
        top: Image<P, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        var redIndex = P.redIndex
        var alphaIndex = P.alphaIndex
        var bottomIndex = 0
        for _ in 0..<bottom.width*bottom.height {
            let topAlpha = top.data[alphaIndex]
            
            if topAlpha > 0 {
                for i in 0..<RGB.channels {
                    bottom.data[bottomIndex+i] *= 1 - topAlpha + top.data[redIndex+i] * topAlpha
                }
            }
            
            redIndex += P.channels
            alphaIndex += P.channels
            bottomIndex += RGB.channels
        }
    }
}
