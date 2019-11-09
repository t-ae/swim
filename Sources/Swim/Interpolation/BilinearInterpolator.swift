import Foundation

public struct BilinearInterpolator<P:PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    @inlinable
    public init(edgeMode: EdgeMode<P, T> = .zero) {
        self.edgeMode = edgeMode
    }

    @inlinable
    public func interpolate(x: Double,
                            y: Double,
                            in image: Image<P, T>,
                            into pixel: UnsafePixelRef<P, T>) {
        // We can unify them, but separate implementation gets better performance gain.
        switch edgeMode {
        case .constant:
            interpolate_constant(x: x, y: y, in: image, into: pixel)
        default:
            interpolate_other(x: x, y: y, in: image, into: pixel)
        }
    }
    
    @inlinable
    func interpolate_constant(x: Double,
                              y: Double,
                              in image: Image<P, T>,
                              into pixel: UnsafePixelRef<P, T>) {
        guard case let .constant(constant) = edgeMode else {
            assertionFailure()
            return
        }
        
        let xmin = floor(x)
        let ymin = floor(y)
        
        // weights
        let wx0 = T(xmin + 1 - x)
        let wx1 = T(x - xmin)
        let wy0 = T(ymin + 1 - y)
        let wy1 = T(y - ymin)
        
        let xp = Int(xmin)
        let yp = Int(ymin)
        let x0 = edgeMode.clampValue(value: xp, max: image.width)
        let x1 = edgeMode.clampValue(value: xp+1, max: image.width)
        let y0 = edgeMode.clampValue(value: yp, max: image.height)
        let y1 = edgeMode.clampValue(value: yp+1, max: image.height)
        
        pixel.pointer.initialize(repeating: 0)
        
        if let y = y0 {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: wx0 * wy0)
            } else {
                pixel.addColor(color: constant, with: wx0 * wy0)
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: wx1 * wy0)
            } else {
                pixel.addColor(color: constant, with: wx1 * wy0)
            }
        } else {
            pixel.setColor(color: constant, with: wy0)
        }
        
        if let y = y1 {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: wx0 * wy1)
            } else {
                pixel.addColor(color: constant, with: wx0 * wy1)
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: wx1 * wy1)
            } else {
                pixel.addColor(color: constant, with: wx1 * wy1)
            }
        } else {
            pixel.addColor(color: constant, with: wy1)
        }
    }
    
    @inlinable
    func interpolate_other(x: Double,
                           y: Double,
                           in image: Image<P, T>,
                           into pixel: UnsafePixelRef<P, T>) {
        if case .constant = edgeMode {
            assertionFailure()
            return
        }
        let xmin = floor(x)
        let ymin = floor(y)
        
        // weights
        let wx0 = T(xmin + 1 - x)
        let wx1 = T(x - xmin)
        let wy0 = T(ymin + 1 - y)
        let wy1 = T(y - ymin)
        
        let xp = Int(xmin)
        let yp = Int(ymin)
        let x0 = edgeMode.clampValue(value: xp, max: image.width)!
        let x1 = edgeMode.clampValue(value: xp+1, max: image.width)!
        let y0 = edgeMode.clampValue(value: yp, max: image.height)!
        let y1 = edgeMode.clampValue(value: yp+1, max: image.height)!
        
        pixel.setColor(x: x0, y: y0, in: image, with: wx0 * wy0)
        pixel.addColor(x: x1, y: y0, in: image, with: wx1 * wy0)
        pixel.addColor(x: x0, y: y1, in: image, with: wx0 * wy1)
        pixel.addColor(x: x1, y: y1, in: image, with: wx1 * wy1)
    }
}
