import Foundation

public struct BicubicInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator4x4 {
    public var a: Double
    public var edgeMode: EdgeMode<P, T>
    
    public init(a: Double = -1, edgeMode: EdgeMode<P, T> = .zero) {
        self.a = a
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func weight(distance: Double) -> Double {
        assert(distance >= 0)
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
}
