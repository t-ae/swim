import Foundation

extension Image where T == Double {
    /// Apply bilateral filter.
    ///
    /// Filter will be applied to each channel separately.
    ///
    /// - Parameters:
    ///   - distanceSigma: Standatd deviation of distance gaussian.
    ///   - valueSigma: Standatd deviation of pixel value gaussian.
    ///
    /// - Precondition: kernelSize > 0
    @inlinable
    public func bilateralFilter(kernelSize: Int, distanceSigma: Double, valueSigma: Double) -> Image {
        precondition(kernelSize > 0, "kernelSize must be greater than 0.")
        
        let distanceSigma2 = distanceSigma * distanceSigma
        let valueSigma2 = valueSigma * valueSigma
    
        let pad = (kernelSize-1)/2
        
        var distanceLUT = Image<Gray, Double>(width: kernelSize, height: kernelSize, value: 0)
        distanceLUT.pixelwiseConvert { ref in
            let dx = ref.x - pad
            let dy = ref.y - pad
            
            ref[.gray] = exp(-Double(dx*dx + dy+dy) / (2*distanceSigma2))
        }
        
        return channelwiseConverted { x, y, c, value in
            var denominator: Double = 0
            var numerator: Double = 0
            
            for py in 0..<kernelSize {
                let yy = clamp(y + py - pad, min: 0, max: height-1)
                
                for px in 0..<kernelSize {
                    let xx = clamp(x + px - pad, min: 0, max: width-1)
                    
                    let distanceGauss = distanceLUT[px, py, .gray]
                    
                    let pixelValue = self[xx, yy, c]
                    let diff = pixelValue - value
                    let valueGauss = exp(-diff*diff / (2*valueSigma2))
                    
                    let prod = distanceGauss * valueGauss
                    
                    denominator += pixelValue * prod
                    numerator += prod
                }
            }
            
            return denominator / numerator
        }
    }
}
