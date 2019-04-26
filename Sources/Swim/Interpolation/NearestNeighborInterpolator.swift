import Foundation

public struct NearestNeighborInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    public init(edgeMode: EdgeMode<P, T> = .zero) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func interpolate(x: T, y: T, in image: Image<P, T>, into pixel: MutablePixelRef<P, T>) {
        let (x, y) = (Int(round(x)), Int(round(y)))
        
        if let (x, y) = inImageCoord(x: x, y: y, width: image.width, height: image.height) {
            pixel.assign(x: x, y: y, in: image)
        } else if case let .constant(px) = edgeMode {
            pixel.assign(pixel: px)
        } else {
            fatalError("Never happens")
        }
    }
}
