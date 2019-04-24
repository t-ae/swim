import Foundation

public struct BicubicInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var a: T
    public var edgeMode: EdgeMode<P, T>
    
    public init(a: T = -1, edgeMode: EdgeMode<P, T> = .zero) {
        self.a = a
        self.edgeMode = edgeMode
    }
    
    @inlinable
    func bicubicWeight(distance: T) -> T {
        guard distance < 2 else {
            return 0
        }
        let d2 = distance*distance
        let d3 = d2*distance
        
        if distance < 1 {
            var result = (a+2) * d3
            result -= (a+3)*d2
            return result + 1
        } else {
            var result = a*d3
            result -= 5*a*d2
            result += 8*a*distance
            return result - 4*a
        }
    }
    
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
        let xw0 = bicubicWeight(distance: x - xmin)
        let xw1 = bicubicWeight(distance: x - xmin - 1)
        let xw2 = bicubicWeight(distance: xmin + 2 - x)
        let xw3 = bicubicWeight(distance: xmin + 3 - x)
        
        let yw0 = bicubicWeight(distance: y - ymin)
        let yw1 = bicubicWeight(distance: y - ymin - 1)
        let yw2 = bicubicWeight(distance: ymin + 2 - y)
        let yw3 = bicubicWeight(distance: ymin + 3 - y)
        
        // Loop unrolling
        var yp = Int(ymin)
        
        // dy = 0
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] = xw0 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.assign(pixel: constant, with: xw0 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw0)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 1
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw1)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 2
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw2)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 3
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw3)
            } else {
                fatalError("Never happens.")
            }
        }
    }
}

/// Slower but simpler version
public struct _BicubicInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator {
    public var a: T
    public var edgeMode: EdgeMode<P, T>
    
    public init(a: T = -1, edgeMode: EdgeMode<P, T> = .zero) {
        self.a = a
        self.edgeMode = edgeMode
    }
    
    @inlinable
    func bicubicWeight(distance: T) -> T {
        guard distance < 2 else {
            return 0
        }
        let d2 = distance*distance
        let d3 = d2*distance
        
        if distance < 1 {
            var result = (a+2) * d3
            result -= (a+3)*d2
            return result + 1
        } else {
            var result = a*d3
            result -= 5*a*d2
            result += 8*a*distance
            return result - 4*a
        }
    }
    
    @inlinable
    public func interpolate(x: T, y: T, in image: Image<P, T>, into pixel: MutablePixelRef<P, T>) {
        let xmin = floor(x) - 1
        let ymin = floor(y) - 1
        
        for c in 0..<P.channels {
            pixel[c] = 0
        }
        
        for dy in 0..<4 {
            let yp = ymin + T(dy)
            let wy = bicubicWeight(distance: abs(yp - y))
            for dx in 0..<4 {
                let xp = xmin + T(dx)
                let wx = bicubicWeight(distance: abs(xp - x))
                
                if let (x, y) = inImageCoord(x: Int(xp), y: Int(yp), width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        pixel[c] += image[unsafe: x, y, c]
                    }
                } else if case let .constant(px) = edgeMode {
                    pixel.add(pixel: px, with: wx * wy)
                } else {
                    fatalError("Never happens")
                }
            }
        }
    }
}
