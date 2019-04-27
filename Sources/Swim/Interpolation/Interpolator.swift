import Foundation

public protocol Interpolator {
    associatedtype P: PixelType
    associatedtype T: BinaryFloatingPoint & DataType
    
    var edgeMode: EdgeMode<P, T> { get set }
    
    @inlinable func interpolate(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T>
    @inlinable func interpolate(x: T, y: T, in image: Image<P, T>, into pixel: MutablePixelRef<P, T>)
}

extension Interpolator {
    @inlinable
    public func interpolate(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(value: 0)
        
        pixel.withUnsafeMutableBufferPointer {
            let ref = MutablePixelRef<P, T>(x: -1, y: -1, pointer: $0)
            interpolate(x: x, y: y, in: image, into: ref)
        }
        
        return pixel
    }
}

extension Interpolator {
    @inlinable
    func clampValue(value: Int, max: Int) -> Int? {
        guard value < 0 || value >= max else {
            // Already inside
            return value
        }
        
        switch edgeMode {
        case .constant:
            return nil
        case .edge:
            return clamp(value, min: 0, max: max-1)
        case .symmetric:
            var x = value
            if x < 0 {
                x = -x - 1
            }
            if x >= 2*max { // Make x in [0, 2*max-1]
                x %= 2*max
            }
            if x >= max {
                x = 2*max - x - 1
            }
            return x
        case .reflect:
            var x = value
            while x < 0 || x >= max {
                if x < 0 {
                    x = -x
                }
                if x >= max {
                    x = 2*max - x - 2
                }
            }
            return x
        case .wrap:
            var x = value
            while x < 0 {
                x += max
            }
            while x >= max {
                x -= max
            }
            return x
        }
    }
    
    @inlinable
    func inImageCoord(x: Int, y: Int, width: Int, height: Int) -> (x: Int, y: Int)? {
        if let x = clampValue(value: x, max: width), let y = clampValue(value: y, max: height) {
            return (x, y)
        } else {
            return nil
        }
    }
}

public enum EdgeMode<P: PixelType, T: DataType> {
    case constant(pixel: Pixel<P, T>)
    case edge
    case symmetric
    case reflect
    case wrap
    
    public static func constant(value: T) -> EdgeMode<P, T> {
        return .constant(pixel: Pixel(value: value))
    }
}

extension EdgeMode where T: AdditiveArithmetic {
    public static var zero: EdgeMode<P, T> {
        return .constant(value: .zero)
    }
}
