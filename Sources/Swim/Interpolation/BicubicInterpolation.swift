import Foundation

extension Image where T: BinaryFloatingPoint {
    
    private func bicubicWeight(distance: T) -> T {
        
        guard distance < 2 else {
            return 0
        }
        let d2 = distance*distance
        let d3 = d2*distance
        
        if distance < 1 {
            var result = d3
            result -= 2*d2
            return result + 1
        } else {
            var result = -d3
            result += 5*d2
            result -= 8*distance
            return result + 4
        }
    }
    
    /// - Preconditions:
    ///   - 0 <= x <= width-1
    ///   - 0 <= y <= height-1
    func interpolateBicubic(x: T, y: T) -> Pixel<P, T> {
        assert(0 <= x && x < T(width))
        assert(0 <= y && y < T(height))
        
        let xmin = Int(x)-1
        let xmax = Int(x)+2
        let ymin = Int(y)-1
        let ymax = Int(y)+2
        
        var pixel = Pixel<P, T>(value: 0)
        var weightSum: T = 0
        
        for yp in ymin...ymax {
            let yy = clamp(yp, min: 0, max: height-1)
            let wy = bicubicWeight(distance: abs(y - T(yp)))
            guard wy > 0 else {
                continue
            }
            
            for xp in xmin...xmax {
                let xx = clamp(xp, min: 0, max: width-1)
                let wx = bicubicWeight(distance: abs(x - T(xp)))
                guard wx > 0 else {
                    continue
                }
                
                pixel += self[unsafe: xx, yy] * wx * wy
                weightSum += wx * wy
                
            }
        }
        
        return pixel / weightSum
    }
}
