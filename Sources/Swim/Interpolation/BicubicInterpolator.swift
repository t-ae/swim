import Foundation

public struct BicubicInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
    public var a: T
    public var edgeMode: EdgeMode<T>
    
    public init(a: T = -1, mode: EdgeMode<T> = .constant(0)) {
        self.a = a
        self.edgeMode = mode
    }
    
    @inlinable
    func bicubicWeight(distance: T) -> T {
        guard distance < 2 else {
            return 0
        }
        let d2 = distance*distance
        let d3 = d2*distance
        
        if distance < 1 {
            var result = (a+2) * d3
            result -= (a+3)*d2
            return result + 1
        } else {
            var result = a*d3
            result -= 5*a*d2
            result += 8*a*distance
            return result - 4*a
        }
    }
    
    @inlinable
    public func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        let xmin = floor(x) - 1
        let ymin = floor(y) - 1
        
        var result = Pixel<P, T>(value: 0)
        
        for dy in 0..<4 {
            let yp = ymin + T(dy)
            let wy = bicubicWeight(distance: abs(yp - y))
            for dx in 0..<4 {
                let xp = xmin + T(dx)
                let wx = bicubicWeight(distance: abs(xp - x))
                
                let px = getPixel(x: Int(xp), y: Int(yp), in: image)
                
                result += wx * wy * px
            }
        }
        return result
    }
}
