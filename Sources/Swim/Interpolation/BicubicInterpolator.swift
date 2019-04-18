import Foundation

public struct BicubicInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
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
        
        
        let xmin_ = Int(xmin)
        let ymin_ = Int(ymin)
        
        var constant: T?
        switch edgeMode {
        case let .constant(value):
            constant = value
        default:
            constant = nil
        }
        
        do {
            let xp = xmin + 0
            let yp = ymin + 0
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+0, y: ymin_+0, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 1
            let yp = ymin + 0
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+1, y: ymin_+0, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 2
            let yp = ymin + 0
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+2, y: ymin_+0, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 3
            let yp = ymin + 0
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+3, y: ymin_+0, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 0
            let yp = ymin + 1
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+0, y: ymin_+1, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 1
            let yp = ymin + 1
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+1, y: ymin_+1, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 2
            let yp = ymin + 1
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+2, y: ymin_+1, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 3
            let yp = ymin + 1
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: y - yp)
            
            if let coord = inImageCoord(x: xmin_+3, y: ymin_+1, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 0
            let yp = ymin + 2
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+0, y: ymin_+2, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 1
            let yp = ymin + 2
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+1, y: ymin_+2, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 2
            let yp = ymin + 2
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+2, y: ymin_+2, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 3
            let yp = ymin + 2
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+3, y: ymin_+2, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 0
            let yp = ymin + 3
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+0, y: ymin_+3, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 1
            let yp = ymin + 3
            let weight = bicubicWeight(distance: x - xp) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+1, y: ymin_+3, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 2
            let yp = ymin + 3
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+2, y: ymin_+3, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
            }
        }
        
        do {
            let xp = xmin + 3
            let yp = ymin + 3
            let weight = bicubicWeight(distance: xp - x) * bicubicWeight(distance: yp - y)
            
            if let coord = inImageCoord(x: xmin_+3, y: ymin_+3, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    result[c] += weight * image[coord.x, coord.y, c]
                }
            } else if let constant = constant {
                result += weight * constant
            } else {
                fatalError("Never happens.")
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
