import Foundation

public struct BilinearInterpolator<P:PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    public init(edgeMode: EdgeMode<P, T> = .zero) {
        self.edgeMode = edgeMode
    }

    @inlinable
    public func interpolate(x: T, y: T, in image: Image<P, T>, into pixel: MutablePixelRef<P, T>) {
        let x0 = floor(x)
        let x1 = x0 + 1
        let y0 = floor(y)
        let y1 = y0 + 1
        
        let x0x = x - x0
        let xx1 = x1 - x
        let y0y = y - y0
        let yy1 = y1 - y
        
        var constant: Pixel<P, T>?
        switch edgeMode {
        case let .constant(px):
            constant = px
        default:
            constant = nil
        }
        
        if let y = edgeMode.clampValue(value: Int(y0), max: image.height) {
            if let x = edgeMode.clampValue(value: Int(x0), max: image.width) {
                pixel.assign(x: x, y: y, in: image, with: xx1 * yy1)
            } else if let constant = constant {
                pixel.assign(pixel: constant, with: xx1 * yy1)
            } else {
                fatalError("Never happens.")
            }
            
            if let x = edgeMode.clampValue(value: Int(x1), max: image.width) {
                pixel.add(x: x, y: y, in: image, with: x0x * yy1)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: x0x * yy1)
            } else {
                fatalError("Never happens.")
            }
        } else if let constant = constant {
            pixel.assign(pixel: constant, with: yy1)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = edgeMode.clampValue(value: Int(y1), max: image.height) {
            if let x = edgeMode.clampValue(value: Int(x0), max: image.width) {
                pixel.add(x: x, y: y, in: image, with: xx1 * y0y)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xx1 * y0y)
            } else {
                fatalError("Never happens.")
            }
            
            if let x = edgeMode.clampValue(value: Int(x1), max: image.width) {
                pixel.add(x: x, y: y, in: image, with: x0x * y0y)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: x0x * y0y)
            } else {
                fatalError("Never happens.")
            }
        } else if let constant = constant {
            pixel.add(pixel: constant, with: y0y)
        } else {
            fatalError("Never happens.")
        }
    }
}
