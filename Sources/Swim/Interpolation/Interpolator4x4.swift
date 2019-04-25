import Foundation

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
