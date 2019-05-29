import Foundation

extension Image where T == Double {
    /// Apply non-local mean filter.
    ///
    /// Filter will be applied to each channel separately.
    ///
    /// - Parameters:
    ///   - sigma2: Variance of pixel value gaussian.
    ///
    /// - Precondition: kernelSize > 0
    @inlinable
    public func nonLocalMeanFilter(kernelSize: Int, sigma2: Double) -> Image {
        precondition(kernelSize > 0, "kernelSize must be greater than 0.")

        let pad = (kernelSize-1)/2
        
        return Image.createWithPixelValues(width: width, height: height) { x, y, c in
            var weightedSum: Double = 0
            var z: Double = 0 // sum of weights
            
            for dy in 0..<kernelSize {
                let ly = y + dy - pad
                for dx in 0..<kernelSize {
                    let lx = x + dx - pad
                    
                    // Compute distance^2
                    var distance2: Double = 0
                    for i in 0..<kernelSize {
                        let yy1 = clamp(y + i - pad, min: 0, max: height-1)
                        let yy2 = clamp(ly + i - pad, min: 0, max: height-1)
                        for j in 0..<kernelSize {
                            let xx1 = clamp(x + j - pad, min: 0, max: width-1)
                            let xx2 = clamp(lx + j - pad, min: 0, max: width-1)
                            
                            let s = self[xx1, yy1, c]
                            let l = self[xx2, yy2, c]
                            distance2 += s*s + l*l - 2*s*l
                        }
                    }
                    
                    let w = exp(-distance2 / sigma2)
                    z += w
                    
                    weightedSum += w * self[clamp(lx, min: 0, max: width-1), clamp(ly, min: 0, max: height-1), c]
                }
            }
            
            // normalize
            return weightedSum / z
        }
    }
}
