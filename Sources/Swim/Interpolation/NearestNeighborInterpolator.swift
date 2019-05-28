import Foundation

public struct NearestNeighborInterpolator<P: PixelType, T: DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    public init(edgeMode: EdgeMode<P, T>) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func interpolate(x: Double, y: Double, in image: Image<P, T>, into pixel: MutablePixelRef<P, T>) {
        let (x, y) = (Int(round(x)), Int(round(y)))
        
        if let x = edgeMode.clampValue(value: x, max: image.width),
            let y = edgeMode.clampValue(value: y, max: image.height) {
            pixel.setColor(x: x, y: y, in: image)
        } else if case let .constant(px) = edgeMode {
            pixel.setColor(color: px)
        } else {
            fatalError("Never happens")
        }
    }
}

extension NearestNeighborInterpolator where T: AdditiveArithmetic {
    public init() {
        self.init(edgeMode: .zero)
    }
}
