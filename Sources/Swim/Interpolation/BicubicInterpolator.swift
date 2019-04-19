import Foundation

public struct BicubicInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
    public var a: T
    public var edgeMode: EdgeMode<T>
    
    public init(a: T = -1, edgeMode: EdgeMode<T> = .constant(0)) {
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
    public func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        let xmin = floor(x) - 1
        let ymin = floor(y) - 1
        
        var result = Pixel<P, T>(value: 0)
        
        var constant: T?
        switch edgeMode {
        case let .constant(value):
            constant = value
        default:
            constant = nil
        }
        
        var yp = ymin
        var yp_ = Int(yp)
        
        // dy = 0
        do {
            let yw = bicubicWeight(distance: y - yp)
            
            var xp = xmin
            var xp_ = Int(xp)
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
        }
        
        yp += 1
        yp_ += 1

        // dy = 1
        do {
            let yw = bicubicWeight(distance: y - yp)
            
            var xp = xmin
            var xp_ = Int(xp)
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
        }
        
        yp += 1
        yp_ += 1
        
        // dy = 2
        do {
            let yw = bicubicWeight(distance: yp - y)
            
            var xp = xmin
            var xp_ = Int(xp)
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
        }
        
        yp += 1
        yp_ += 1
        
        // dy = 3
        do {
            let yw = bicubicWeight(distance: yp - y)
            
            var xp = xmin
            var xp_ = Int(xp)
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: x - xp) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
            xp += 1
            xp_ += 1
            
            do {
                let weight = bicubicWeight(distance: xp - x) * yw
                
                if let coord = inImageCoord(x: xp_, y: yp_, width: image.width, height: image.height) {
                    for c in 0..<P.channels {
                        result[c] += weight * image[unsafe: coord.x, coord.y, c]
                    }
                } else if let constant = constant {
                    result += weight * constant
                } else {
                    fatalError("Never happens.")
                }
            }
        }
        
        return result
    }
}

/// Slower but simpler version
public struct _BicubicInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
    public var a: T
    public var edgeMode: EdgeMode<T>
    
    public init(a: T = -1, mode: EdgeMode<T> = .constant(0)) {
        self.a = a
        self.edgeMode = mode
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
    public func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        let xmin = floor(x) - 1
        let ymin = floor(y) - 1
        
        var result = Pixel<P, T>(value: 0)
        
        for dy in 0..<4 {
            let yp = ymin + T(dy)
            let wy = bicubicWeight(distance: abs(yp - y))
            for dx in 0..<4 {
                let xp = xmin + T(dx)
                let wx = bicubicWeight(distance: abs(xp - x))
                
                let px = getPixel(x: Int(xp), y: Int(yp), in: image)
                
                result += wx * wy * px
            }
        }
        
        return result
    }
}
