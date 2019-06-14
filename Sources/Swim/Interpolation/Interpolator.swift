import Foundation

public protocol Interpolator {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    var edgeMode: EdgeMode<P, T> { get set }
    
    func interpolate(x: Double, y: Double, in image: Image<P, T>) -> Color<P, T>
    func interpolate(x: Double, y: Double, in image: Image<P, T>, into pixel: UnsafePixelRef<P, T>)
}

extension Interpolator {
    @inlinable
    public func interpolate(x: Double, y: Double, in image: Image<P, T>) -> Color<P, T> {
        return Color.createWithUnsafeMutableBufferPointer { bp in
            let ref = UnsafePixelRef<P, T>(x: -1, y: -1, pointer: bp)
            interpolate(x: x, y: y, in: image, into: ref)
        }
    }
}
