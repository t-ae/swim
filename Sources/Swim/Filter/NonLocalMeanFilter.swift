import Foundation

extension Image where T == Double {
    /// Apply non-local mean filter.
    ///
    /// Filter will be applied to each channel separately.
    ///
    /// - Parameters:
    ///   - distance: Max distance to patch to refer.
    ///   - sigma: Standatd deviation of pixel value gaussian.
    ///
    /// - Precondition: windowSize > 0
    @inlinable
    public func nonLocalMeanFilter(windowSize: Int, distance: Int, sigma: Double) -> Image {
        precondition(distance >= 0, "distance must be positive.")
        precondition(windowSize > 0, "windowSize must be greater than 0.")
        
        let pad = (windowSize-1)/2
        let sigma2 = sigma*sigma
        
        return .createWithPixelValues(width: width, height: height) { x, y, c in
            var weightedSum: Double = 0
            var weightSum: Double = 0
            
            for dy in -distance...distance {
                let ly = y + dy
                guard 0 <= ly && ly < height else {
                    continue
                }
                for dx in -distance...distance {
                    let lx = x + dx
                    guard 0 <= lx && lx < width else {
                        continue
                    }
                    
                    // Compute distance^2
                    var distance2: Double = 0
                    for i in 0..<windowSize {
                        let yy1 = clamp(y + i - pad, min: 0, max: height-1)
                        let yy2 = clamp(ly + i - pad, min: 0, max: height-1)
                        for j in 0..<windowSize {
                            let xx1 = clamp(x + j - pad, min: 0, max: width-1)
                            let xx2 = clamp(lx + j - pad, min: 0, max: width-1)
                            
                            let s = self[xx1, yy1, c]
                            let l = self[xx2, yy2, c]
                            distance2 += (s-l)*(s-l)
                        }
                    }
                    
                    let w = exp(-distance2 / sigma2)
                    weightSum += w
                    
                    weightedSum += w * self[lx, ly, c]
                }
            }
            
            // normalize
            return weightedSum / weightSum
        }
    }
}
