import Foundation

public struct BilinearInterpolator<P:PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    @inlinable
    public init(edgeMode: EdgeMode<P, T> = .zero) {
        self.edgeMode = edgeMode
    }

    @inlinable
    public func interpolate(x: Double, y: Double, in image: Image<P, T>, into pixel: UnsafePixelRef<P, T>) {
        let xmin = floor(x)
        let ymin = floor(y)
        
        var constant: Color<P, T>?
        switch edgeMode {
        case let .constant(px):
            constant = px
        default:
            constant = nil
        }
        
        // weights
        let wx0 = T(xmin + 1 - x)
        let wx1 = T(x - xmin)
        let wy0 = T(ymin + 1 - y)
        let wy1 = T(y - ymin)
        
        let xp = Int(xmin)
        let yp = Int(ymin)
        let x0 = edgeMode.clampValue(value: xp, max: image.width)
        let x1 = edgeMode.clampValue(value: xp+1, max: image.width)
        
        if let y = edgeMode.clampValue(value: yp, max: image.height) {
            if let x = x0 {
                pixel.setColor(x: x, y: y, in: image, with: wx0 * wy0)
            } else if let constant = constant {
                pixel.setColor(color: constant, with: wx0 * wy0)
            } else {
                fatalError("Never happens.")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: wx1 * wy0)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: wx1 * wy0)
            } else {
                fatalError("Never happens.")
            }
        } else if let constant = constant {
            pixel.setColor(color: constant, with: wy0)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = edgeMode.clampValue(value: yp+1, max: image.height) {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: wx0 * wy1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: wx0 * wy1)
            } else {
                fatalError("Never happens.")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: wx1 * wy1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: wx1 * wy1)
            } else {
                fatalError("Never happens.")
            }
        } else if let constant = constant {
            pixel.addColor(color: constant, with: wy1)
        } else {
            fatalError("Never happens.")
        }
    }
}
