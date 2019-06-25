import Foundation

public struct NearestNeighborInterpolator<P: PixelType, T: DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    @inlinable
    public init(edgeMode: EdgeMode<P, T>) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func interpolate(x: Double,
                            y: Double,
                            in image: Image<P, T>,
                            into pixel: UnsafePixelRef<P, T>) {
        let (x, y) = (Int(round(x)), Int(round(y)))
        
        pixel.setColor(x: x, y: y, in: image, edgeMode: edgeMode)
    }
}

extension NearestNeighborInterpolator where T: AdditiveArithmetic {
    public init() {
        self.init(edgeMode: .zero)
    }
}
