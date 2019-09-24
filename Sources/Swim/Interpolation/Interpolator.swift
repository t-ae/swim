public protocol Interpolator {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    var edgeMode: EdgeMode<P, T> { get set }
    
    func interpolate(x: Double, y: Double, in image: Image<P, T>, into pixel: UnsafePixelRef<P, T>)
}

extension Image {
    /// Interpolate color.
    @inlinable
    public subscript<Intpl: Interpolator>(x: Double, y: Double, interpolator interpolator: Intpl) -> Color<P, T> where Intpl.P == P, Intpl.T == T {
        return .createWithUnsafeMutableBufferPointer {
            let ref = UnsafePixelRef<P, T>(x: -1, y: -1, pointer: $0)
            interpolator.interpolate(x: x, y: y, in: self, into: ref)
        }
    }
}
