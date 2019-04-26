import Foundation

/// Protocol for interpolators which refers 16 pixels.
public protocol Interpolator4x4: Interpolator {
    func weight(distance: T) -> T
}

extension Interpolator4x4 {
    @inlinable
    public func interpolate(x: T, y: T, in image: Image<P, T>, into pixel: MutablePixelRef<P, T>) {
        let xmin = floor(x) - 1
        let ymin = floor(y) - 1
        
        var constant: Pixel<P, T>?
        switch edgeMode {
        case let .constant(px):
            constant = px
        default:
            constant = nil
        }
        
        // weights
        let xw0 = weight(distance: x - xmin)
        let xw1 = weight(distance: x - xmin - 1)
        let xw2 = weight(distance: xmin + 2 - x)
        let xw3 = weight(distance: xmin + 3 - x)
        
        let yw0 = weight(distance: y - ymin)
        let yw1 = weight(distance: y - ymin - 1)
        let yw2 = weight(distance: ymin + 2 - y)
        let yw3 = weight(distance: ymin + 3 - y)
        
        // Loop unrolling
        let yp = Int(ymin)
        
        let xp = Int(xmin)
        let x0 = clampValue(value: xp+0, max: image.width)
        let x1 = clampValue(value: xp+1, max: image.width)
        let x2 = clampValue(value: xp+2, max: image.width)
        let x3 = clampValue(value: xp+3, max: image.width)
        
        if let y = clampValue(value: yp+0, max: image.height) {
            if let x = x0 {
                pixel.assign(x: x, y: y, in: image, with: xw0 * yw0)
            } else if let constant = constant {
                pixel.assign(pixel: constant, with: xw0 * yw0)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.add(x: x, y: y, in: image, with: xw1 * yw0)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw0)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.add(x: x, y: y, in: image, with: xw2 * yw0)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw0)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.add(x: x, y: y, in: image, with: xw3 * yw0)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw0)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.assign(pixel: constant, with: yw0)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = clampValue(value: yp+1, max: image.height) {
            if let x = x0 {
                pixel.add(x: x, y: y, in: image, with: xw0 * yw1)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw1)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.add(x: x, y: y, in: image, with: xw1 * yw1)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw1)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.add(x: x, y: y, in: image, with: xw2 * yw1)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw1)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.add(x: x, y: y, in: image, with: xw3 * yw1)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw1)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.add(pixel: constant, with: yw1)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = clampValue(value: yp+2, max: image.height) {
            if let x = x0 {
                pixel.add(x: x, y: y, in: image, with: xw0 * yw2)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw2)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.add(x: x, y: y, in: image, with: xw1 * yw2)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw2)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.add(x: x, y: y, in: image, with: xw2 * yw2)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw2)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.add(x: x, y: y, in: image, with: xw3 * yw2)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw2)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.add(pixel: constant, with: yw2)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = clampValue(value: yp+3, max: image.height) {
            if let x = x0 {
                pixel.add(x: x, y: y, in: image, with: xw0 * yw3)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw3)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.add(x: x, y: y, in: image, with: xw1 * yw3)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw3)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.add(x: x, y: y, in: image, with: xw2 * yw3)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw3)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.add(x: x, y: y, in: image, with: xw3 * yw3)
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw3)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.add(pixel: constant, with: yw3)
        } else {
            fatalError("Never happens.")
        }
    }
}
