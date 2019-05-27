import Foundation

extension Image where T == Double {
    /// Apply bilateral filter.
    ///
    /// Filter will be applied to each channel separately.
    ///
    /// - Parameters:
    ///   - sigma2_1: Variance of distance gaussian.
    ///   - sigma2_2: Variance of pixel value gaussian.
    ///
    /// - Precondition: kernelSize > 0
    @inlinable
    public func bilateralFilter(kernelSize: Int, sigma2_1: Double, sigma2_2: Double) -> Image {
        precondition(kernelSize > 0, "kernelSize must be greater than 0.")
        
        var newImage = Image<P, T>(width: width, height: height, value: 0)
        
        let pad = (kernelSize-1)/2
        
        var distanceLUT = Image<Gray, Double>(width: kernelSize, height: kernelSize, value: 0)
        distanceLUT.pixelwiseConvert { ref in
            let dx = ref.x - pad
            let dy = ref.y - pad
            
            ref[.gray] = exp(-Double(dx*dx + dy+dy) / (2*sigma2_1))
        }
        
        newImage.pixelwiseConvert { ref in
            for c in 0..<P.channels {
                let centerValue = self[ref.x, ref.y, c]
                
                var denominator: Double = 0
                var numerator: Double = 0
                
                for py in 0..<kernelSize {
                    let yy = clamp(ref.y + py - pad, min: 0, max: height-1)
                    
                    for px in 0..<kernelSize {
                        let xx = clamp(ref.x + px - pad, min: 0, max: width-1)
                        
                        let distanceGauss = distanceLUT[px, py, .gray]
                        
                        let pixelValue = self[xx, yy, c]
                        let diff = pixelValue - centerValue
                        let valueGauss = exp(-diff*diff / (2*sigma2_2))
                        
                        let prod = distanceGauss * valueGauss
                        
                        denominator += pixelValue * prod
                        numerator += prod
                    }
                }
                
                ref[c] = denominator / numerator
            }
        }
        
        return newImage
    }
}
