import Foundation

public struct NearestNeighborInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    public init(edgeMode: EdgeMode<P, T> = .constant(value: 0)) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func interpolate(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        let (x, y) = (Int(round(x)), Int(round(y)))
        
        if let (x, y) = inImageCoord(x: x, y: y, width: image.width, height: image.height) {
            return image[unsafe: x, y]
        } else if case let .constant(pixel) = edgeMode {
            return pixel
        } else {
            preconditionFailure("Never happens")
        }
    }
}
