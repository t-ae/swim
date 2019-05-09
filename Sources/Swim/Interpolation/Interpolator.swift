import Foundation

public protocol Interpolator {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    var edgeMode: EdgeMode<P, T> { get set }
    
    func interpolate(x: Double, y: Double, in image: Image<P, T>) -> Pixel<P, T>
    func interpolate(x: Double, y: Double, in image: Image<P, T>, into pixel: MutablePixelRef<P, T>)
}

extension Interpolator {
    @inlinable
    public func interpolate(x: Double, y: Double, in image: Image<P, T>) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(value: T.swimDefaultValue)
        
        pixel.withUnsafeMutableBufferPointer {
            let ref = MutablePixelRef<P, T>(x: -1, y: -1, pointer: $0)
            interpolate(x: x, y: y, in: image, into: ref)
        }
        
        return pixel
    }
}
