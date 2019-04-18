public struct NearestNeighborInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
    public var mode: InterpolationMode<T>
    
    public init(mode: InterpolationMode<T> = .constant(0)) {
        self.mode = mode
    }
    
    @inlinable
    public func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        return getPixel(x: x, y: y, in: image)
    }
}
