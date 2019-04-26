import Foundation

public struct BicubicInterpolator<P: PixelType, T: BinaryFloatingPoint&DataType>: Interpolator4x4 {
    public var a: T
    public var edgeMode: EdgeMode<P, T>
    
    public init(a: T = -1, edgeMode: EdgeMode<P, T> = .zero) {
        self.a = a
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func weight(distance: T) -> T {
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
                        pixel[c] += image[x, y, c]
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
