import Foundation

/// Lanczos2 interpolator.
public struct Lanczos2Interpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator4x4 {
    public var edgeMode: EdgeMode<P, T>
    
    public init(edgeMode: EdgeMode<P, T> = .zero) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func weight(distance: Double) -> Double {
        assert(distance >= 0)
        guard distance < 2 else {
            return 0
        }
        // sinc(distance) * sinc(distance/2)
        guard distance != 0 else {
            return 1
        }
        let xpi = distance * .pi
        
        return 2 * sin(xpi) * sin(xpi/2) / (xpi*xpi)
    }
}


/// Lanczos3 interpolator.
public struct Lanczos3Interpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<P, T>
    
    public init(edgeMode: EdgeMode<P, T> = .zero) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func weight(distance: Double) -> Double {
        assert(distance >= 0)
        guard distance < 3 else {
            return 0
        }
        // sinc(distance) * sinc(distance/3)
        guard distance != 0 else {
            return 1
        }
        let xpi = distance * .pi
        
        return 3 * sin(xpi) * sin(xpi/3) / (xpi*xpi)
    }
    
    @inlinable
    public func interpolate(x: Double,
                            y: Double,
                            in image: Image<P, T>,
                            into pixel: PixelRef<P, T>) {
        let xmin = floor(x) - 2
        let ymin = floor(y) - 2
        
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
        let xw2 = T(weight(distance: x - xmin - 2))
        let xw3 = T(weight(distance: xmin + 3 - x))
        let xw4 = T(weight(distance: xmin + 4 - x))
        let xw5 = T(weight(distance: xmin + 5 - x))
        
        let yw0 = T(weight(distance: y - ymin))
        let yw1 = T(weight(distance: y - ymin - 1))
        let yw2 = T(weight(distance: y - ymin - 2))
        let yw3 = T(weight(distance: ymin + 3 - y))
        let yw4 = T(weight(distance: ymin + 4 - y))
        let yw5 = T(weight(distance: ymin + 5 - y))
        
        // Loop unrolling
        let yp = Int(ymin)
        
        let xp = Int(xmin)
        let x0 = edgeMode.clampValue(value: xp+0, max: image.width)
        let x1 = edgeMode.clampValue(value: xp+1, max: image.width)
        let x2 = edgeMode.clampValue(value: xp+2, max: image.width)
        let x3 = edgeMode.clampValue(value: xp+3, max: image.width)
        let x4 = edgeMode.clampValue(value: xp+4, max: image.width)
        let x5 = edgeMode.clampValue(value: xp+5, max: image.width)

        if let y = edgeMode.clampValue(value: yp+0, max: image.height) {
            if let x = x0 {
                pixel.setColor(x: x, y: y, in: image, with: xw0 * yw0)
            } else if let constant = constant {
                pixel.setColor(color: constant, with: xw0 * yw0)
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
            
            if let x = x4 {
                pixel.addColor(x: x, y: y, in: image, with: xw4 * yw0)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw4 * yw0)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x5 {
                pixel.addColor(x: x, y: y, in: image, with: xw5 * yw0)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw5 * yw0)
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
            
            if let x = x4 {
                pixel.addColor(x: x, y: y, in: image, with: xw4 * yw1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw4 * yw1)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x5 {
                pixel.addColor(x: x, y: y, in: image, with: xw5 * yw1)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw5 * yw1)
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
            
            if let x = x4 {
                pixel.addColor(x: x, y: y, in: image, with: xw4 * yw2)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw4 * yw2)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x5 {
                pixel.addColor(x: x, y: y, in: image, with: xw5 * yw2)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw5 * yw2)
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
            
            if let x = x4 {
                pixel.addColor(x: x, y: y, in: image, with: xw4 * yw3)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw4 * yw3)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x5 {
                pixel.addColor(x: x, y: y, in: image, with: xw5 * yw3)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw5 * yw3)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.addColor(color: constant, with: yw3)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = edgeMode.clampValue(value: yp+4, max: image.height) {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: xw0 * yw4)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw0 * yw4)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: xw1 * yw4)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw1 * yw4)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.addColor(x: x, y: y, in: image, with: xw2 * yw4)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw2 * yw4)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.addColor(x: x, y: y, in: image, with: xw3 * yw4)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw3 * yw4)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x4 {
                pixel.addColor(x: x, y: y, in: image, with: xw4 * yw4)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw4 * yw4)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x5 {
                pixel.addColor(x: x, y: y, in: image, with: xw5 * yw4)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw5 * yw4)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.addColor(color: constant, with: yw4)
        } else {
            fatalError("Never happens.")
        }
        
        if let y = edgeMode.clampValue(value: yp+5, max: image.height) {
            if let x = x0 {
                pixel.addColor(x: x, y: y, in: image, with: xw0 * yw5)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw0 * yw5)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x1 {
                pixel.addColor(x: x, y: y, in: image, with: xw1 * yw5)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw1 * yw5)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x2 {
                pixel.addColor(x: x, y: y, in: image, with: xw2 * yw5)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw2 * yw5)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x3 {
                pixel.addColor(x: x, y: y, in: image, with: xw3 * yw5)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw3 * yw5)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x4 {
                pixel.addColor(x: x, y: y, in: image, with: xw4 * yw5)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw4 * yw5)
            } else {
                fatalError("Never happens")
            }
            
            if let x = x5 {
                pixel.addColor(x: x, y: y, in: image, with: xw5 * yw5)
            } else if let constant = constant {
                pixel.addColor(color: constant, with: xw5 * yw5)
            } else {
                fatalError("Never happens")
            }
        } else if let constant = constant {
            // all pixels are constant
            pixel.addColor(color: constant, with: yw5)
        } else {
            fatalError("Never happens.")
        }
    }
}
