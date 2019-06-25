public struct BicubicInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator4x4 {
    public var a: Double
    public var edgeMode: EdgeMode<P, T>
    
    @inlinable
    public init(a: Double = -0.5, edgeMode: EdgeMode<P, T> = .zero) {
        self.a = a
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func weight(distance: Double) -> Double {
        assert(distance >= 0)
        guard distance < 2 else {
            return 0
        }
        
        if distance < 1 {
            // (a+2)d^3 - (a+3)d^2 + 1
            // = ((a+2)d - (a + 3))d^2 + 1
            var result = (a+2) * distance
            result -= (a+3)
            result *= distance * distance
            return result + 1
        } else {
            // ad^3 - 5ad^2 +8ad - 4a
            // = a(d-1)(d-2)^2
            var result = distance - 2
            result *= result
            result *= distance - 1
            return a * result
        }
    }
}
