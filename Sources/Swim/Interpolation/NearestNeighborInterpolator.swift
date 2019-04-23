import Foundation

public struct NearestNeighborInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    public init(edgeMode: EdgeMode<P, T> = .constant(value: 0)) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func interpolate(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        return getPixel(x: Int(round(x)), y: Int(round(y)), in: image)
    }
}
