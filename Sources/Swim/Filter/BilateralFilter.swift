import Foundation

extension Image where T == Double {
    /// Apply bilateral filter.
    ///
    /// - Parameters:
    ///   - sigma2_1: Variance of distance gaussian.
    ///   - sigma2_2: Variance of pixel value gaussian.
    @inlinable
    public func bilateralFilter(kernelSize: Int, sigma2_1: Double, sigma2_2: Double) -> Image {
        var newImage = Image<P, T>(width: width, height: height, value: 0)
        
        let pad = (kernelSize-1)/2
        
        for y in 0..<height {
            for x in 0..<width {
                for c in 0..<P.channels {
                    let centerValue = self[x, y, c]
                    
                    var denominator: Double = 0
                    var numerator: Double = 0
                    
                    for py in -pad..<kernelSize-pad {
                        let yy = clamp(y + py, min: 0, max: height-1)
                        
                        for px in -pad..<kernelSize-pad {
                            let xx = clamp(x + px, min: 0, max: width-1)
                            
                            let pixelValue = self[xx, yy, c]
                            let distanceGauss = exp(-hypot(Double(px), Double(py)) / (2*sigma2_1))
                            
                            let diff = pixelValue - centerValue
                            let valueGauss = exp(-diff*diff / (2*sigma2_2))
                            
                            let prod = distanceGauss * valueGauss
                            
                            denominator += pixelValue * prod
                            numerator += prod
                        }
                    }
                    
                    newImage[x, y, c] = denominator / numerator
                }
            }
        }
        
        return newImage
    }
}
