import Foundation

/// Lanczos2 interpolator
///
/// Note: Currently its only for Double since it requires `sin`, which is not generic now.
public struct Lanczos2Interpolator<P: PixelType>: Interpolator4x4 {
    public var edgeMode: EdgeMode<P, Double>
    
    public init(edgeMode: EdgeMode<P, Double> = .zero) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    func sinc(_ x: Double) -> Double {
        guard x != 0 else {
            return 1
        }
        return sin(x * .pi) / (x * .pi)
    }
    
    @inlinable
    public func weight(distance: Double) -> Double {
        guard -2 < distance && distance < 2 else {
            return 0
        }
        return sinc(distance) * sinc(distance/2)
    }
}

