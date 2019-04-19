import Foundation

public struct NearestNeighborInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<T>
    
    public init(edgeMode: EdgeMode<T> = .constant(0)) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        return getPixel(x: Int(round(x)), y: Int(round(y)), in: image)
    }
}
