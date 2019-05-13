import Foundation

extension Blender {
    @inlinable
    public static func overlayBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        for i in 0..<bottom.data.count {
            if top.data[i]*2 < 1 {
                // 2ab
                bottom.data[i] *= 2*top.data[i]
            } else {
                // 1 - 2(1-a)(1-b)
                bottom.data[i] *= 2*(1 - top.data[i])
                bottom.data[i] += 2*top.data[i] - 1
            }
        }
    }
    
    @inlinable
    public static func overlayBlend<P: RGBWithAlpha, T: FloatingPoint>(
        top: Image<P, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        var redIndex = P.redIndex
        var alphaIndex = P.alphaIndex
        var bottomIndex = 0
        for _ in 0..<bottom.width*bottom.height {
            let topAlpha = top.data[alphaIndex]
            
            if topAlpha > 0 {
                for i in 0..<RGB.channels {
                    if top.data[redIndex+i]*2 < 1 {
                        // dst * (1 - srcAlpha) + 2 * dst * src * srcAlpha
                        bottom.data[bottomIndex+i] *= 1 - topAlpha + 2 * top.data[redIndex+i] * topAlpha
                    } else {
                        // dst * (1 - srcAlpha) * (1 - 2*(1-srcColor)*(1-dst))*srcAlpha
                        var s = (1 - top.data[redIndex+i]) * (1 - bottom.data[bottomIndex+i])
                        s = 1 - 2 * s
                        bottom.data[bottomIndex+i] *= 1 - topAlpha
                        bottom.data[bottomIndex+i] += s * topAlpha
                    }
                }
            }
            
            redIndex += P.channels
            alphaIndex += P.channels
            bottomIndex += RGB.channels
        }
    }
}
