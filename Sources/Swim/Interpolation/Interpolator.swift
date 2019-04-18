import Foundation

public protocol Interpolator {
    associatedtype T: BinaryFloatingPoint & DataType
    
    var mode: InterpolationMode<T> { get }
    func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T>
}

extension Interpolator {
    @inlinable
    func inImageCoord(x: T, y: T, width: T, height: T) -> (x: T, y: T)? {
        var (x, y) = (x, y)
        
        guard x < 0 || x >= width || y < 0 || y >= height else {
            // Already inside image
            return (x, y)
        }
        
        switch mode {
        case .constant:
            return nil
        case .edge:
            x = clamp(x, min: 0, max: width-1)
            y = clamp(y, min: 0, max: height-1)
        case .reflect:
            while x < 0 || x >= width {
                if x < 0 {
                    x = -x
                }
                if x >= width {
                    x = width - x
                }
            }
            while y < 0 || y >= height {
                if y < 0 {
                    y = -y
                }
                if y >= height {
                    y = height - y
                }
            }
        case .wrap:
            while x < 0 {
                x += width
            }
            while x >= width {
                x -= width
            }
            while y < 0 {
                y += height
            }
            while y >= height {
                y -= height
            }
        }
        
        return (x, y)
    }
    
    @inlinable
    func getPixel<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        if let (x, y) = inImageCoord(x: x, y: y, width: T(image.width), height: T(image.height)) {
            return image[Int(x), Int(y)]
        } else {
            switch mode {
            case let .constant(value):
                return Pixel(value: value)
            default:
                preconditionFailure("Never happens")
            }
        }
    }
}

public enum InterpolationMode<T: BinaryFloatingPoint> {
    case constant(T)
    case edge
    case reflect
    case wrap
}
