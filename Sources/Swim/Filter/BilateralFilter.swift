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
    /// - Precondition: windowSize > 0
    @inlinable
    public func bilateralFilter(windowSize: Int, distanceSigma: Double, valueSigma: Double) -> Image {
        precondition(windowSize > 0, "windowSize must be greater than 0.")
        
        let distanceSigma2 = distanceSigma * distanceSigma
        let valueSigma2 = valueSigma * valueSigma
    
        let pad = (windowSize-1)/2
        
        let distanceLUT: Matrix<Double>
        do {
            let d = Matrix(rows: 1, cols: windowSize, data: (0..<windowSize).map { x -> Double in
                let d = x - pad
                return exp(-Double(d*d) / (2*distanceSigma2))
            })
            distanceLUT = d.transposed() * d
        }
        
        return channelwiseConverted { x, y, c, value in
            var numerator: Double = 0
            var denominator: Double = 0
            
            for py in 0..<windowSize {
                let yy = clamp(y + py - pad, min: 0, max: height-1)
                
                for px in 0..<windowSize {
                    let xx = clamp(x + px - pad, min: 0, max: width-1)
                    
                    let distanceGauss = distanceLUT[py, px]
                    
                    let pixelValue = self[xx, yy, c]
                    let diff = pixelValue - value
                    let valueGauss = exp(-diff*diff / (2*valueSigma2))
                    
                    let prod = distanceGauss * valueGauss
                    
                    numerator += pixelValue * prod
                    denominator += prod
                }
            }
            
            return numerator / denominator
        }
    }
}
