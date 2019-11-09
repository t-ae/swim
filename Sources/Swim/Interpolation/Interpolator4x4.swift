import Foundation

/// Protocol for interpolators which refers neighbor 16 pixels.
public protocol Interpolator4x4: Interpolator where T: BinaryFloatingPoint {
    func weight(distance: Double) -> Double
}

extension Interpolator4x4 {
    @inlinable
    public func interpolate(x: Double,
                            y: Double,
                            in image: Image<P, T>,
                            into pixel: UnsafePixelRef<P, T>) {
        let xmin = floor(x) - 1
        let ymin = floor(y) - 1
        
        var constant: Color<P, T>?
        switch edgeMode {
        case let .constant(px):
            constant = px
        default:
            constant = nil
        }
        
        // weights
        let xw0 = T(weight(distance: x - xmin))
        let xw1 = T(weight(distance: x - xmin - 1))
        let xw2 = T(weight(distance: xmin + 2 - x))
        let xw3 = T(weight(distance: xmin + 3 - x))
        
        let yw0 = T(weight(distance: y - ymin))
        let yw1 = T(weight(distance: y - ymin - 1))
        let yw2 = T(weight(distance: ymin + 2 - y))
        let yw3 = T(weight(distance: ymin + 3 - y))
        
        // Loop unrolling
        let yp = Int(ymin)
        
        let xp = Int(xmin)
        let x0 = edgeMode.clampValue(value: xp+0, max: image.width)
        let x1 = edgeMode.clampValue(value: xp+1, max: image.width)
        let x2 = edgeMode.clampValue(value: xp+2, max: image.width)
        let x3 = edgeMode.clampValue(value: xp+3, max: image.width)
        
        pixel.pointer.initialize(repeating: 0)
        
        if let y = edgeMode.clampValue(value: yp+0, max: image.height) {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: xw0 * yw0)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw0 * yw0)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: xw1 * yw0)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw1 * yw0)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.addColor(x: x, y: y, in: image, with: xw2 * yw0)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw2 * yw0)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.addColor(x: x, y: y, in: image, with: xw3 * yw0)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw3 * yw0)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.setColor(color: constant, with: yw0)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = edgeMode.clampValue(value: yp+1, max: image.height) {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: xw0 * yw1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw0 * yw1)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: xw1 * yw1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw1 * yw1)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.addColor(x: x, y: y, in: image, with: xw2 * yw1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw2 * yw1)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.addColor(x: x, y: y, in: image, with: xw3 * yw1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw3 * yw1)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.addColor(color: constant, with: yw1)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = edgeMode.clampValue(value: yp+2, max: image.height) {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: xw0 * yw2)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw0 * yw2)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: xw1 * yw2)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw1 * yw2)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.addColor(x: x, y: y, in: image, with: xw2 * yw2)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw2 * yw2)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.addColor(x: x, y: y, in: image, with: xw3 * yw2)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw3 * yw2)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.addColor(color: constant, with: yw2)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = edgeMode.clampValue(value: yp+3, max: image.height) {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: xw0 * yw3)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw0 * yw3)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: xw1 * yw3)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw1 * yw3)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.addColor(x: x, y: y, in: image, with: xw2 * yw3)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw2 * yw3)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.addColor(x: x, y: y, in: image, with: xw3 * yw3)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw3 * yw3)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.addColor(color: constant, with: yw3)
        } else {
            fatalError("Never happens.")
        }
    }
}
