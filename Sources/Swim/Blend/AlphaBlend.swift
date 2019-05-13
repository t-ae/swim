import Foundation

extension Blender {
    @inlinable
    public static func alphaBlend<P1: RGBWithAlpha, P2: RGBWithAlpha, T: FloatingPoint>(
        top: Image<P1, T>, bottom: inout Image<P2, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        var topRedIndex = P1.redIndex
        var topAlphaIndex = P1.alphaIndex
        var bottomRedIndex = P2.redIndex
        var bottomAlphaIndex = P2.alphaIndex
        
        for _ in 0..<bottom.width*bottom.height {
            let topAlpha = top.data[topAlphaIndex]
            let bottomAlpha = bottom.data[bottomAlphaIndex]
            
             if topAlpha == 0 {
                if bottomAlpha == 0 {
                    // set all zero
                    bottom.data[bottomRedIndex+0] = 0
                    bottom.data[bottomRedIndex+1] = 0
                    bottom.data[bottomRedIndex+2] = 0
                } else {
                    // keep bottom
                }
            } else {
                let factor = (1-topAlpha)*bottomAlpha
                let blendAlpha = topAlpha + factor
                
                bottom.data[bottomRedIndex+0] *= factor
                bottom.data[bottomRedIndex+0] += topAlpha * top.data[topRedIndex+0]
                bottom.data[bottomRedIndex+0] /= blendAlpha
                
                bottom.data[bottomRedIndex+1] *= factor
                bottom.data[bottomRedIndex+1] += topAlpha * top.data[topRedIndex+1]
                bottom.data[bottomRedIndex+1] /= blendAlpha
                
                bottom.data[bottomRedIndex+2] *= factor
                bottom.data[bottomRedIndex+2] += topAlpha * top.data[topRedIndex+2]
                bottom.data[bottomRedIndex+2] /= blendAlpha
                
                bottom.data[bottomAlphaIndex] = blendAlpha
            }
            
            topRedIndex += P1.channels
            topAlphaIndex += P1.channels
            bottomRedIndex += P2.channels
            bottomAlphaIndex += P2.channels
        }
    }
}

extension Blender {
    @inlinable
    public static func alphaBlend<P: RGBWithAlpha, T: FloatingPoint>(
        top: Image<P, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        var redIndex = P.redIndex
        var alphaIndex = P.alphaIndex
        var bottomIndex = 0
        for _ in 0..<bottom.width*bottom.height {
            let topAlpha = top.data[alphaIndex]
            
            if topAlpha > 0 {
                for i in 0..<RGB.channels {
                    bottom.data[bottomIndex+i] *= 1 - topAlpha
                    bottom.data[bottomIndex+i] += topAlpha * top.data[redIndex+i]
                }
            }
            
            redIndex += P.channels
            alphaIndex += P.channels
            bottomIndex += RGB.channels
        }
    }
}
