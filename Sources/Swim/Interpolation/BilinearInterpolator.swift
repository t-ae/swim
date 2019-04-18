import Foundation

public struct BilinearInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
    public var edgeMode: EdgeMode<T>
    
    public init(mode: EdgeMode<T> = .constant(0)) {
        self.edgeMode = mode
    }
    
    @inlinable
    public func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T> {
        let x0 = floor(x)
        let x1 = x0 + 1
        let y0 = floor(y)
        let y1 = y0 + 1
        
        let x0x = x - x0
        let xx1 = x1 - x
        let y0y = y - y0
        let yy1 = y1 - y
        
        var result = Pixel<P, T>(value: 0)
        
        var constant: T?
        switch edgeMode {
        case let .constant(value):
            constant = value
        default:
            constant = nil
        }
        
        if let lu = inImageCoord(x: Int(x0), y: Int(y0), width: image.width, height: image.height) {
            for c in 0..<P.channels {
                result[c] += xx1 * yy1 * image[lu.x, lu.y, c]
            }
        } else if let constant = constant {
            result += xx1 * yy1 * constant
        } else {
            fatalError("Never happens.")
        }
        
        if let ru = inImageCoord(x: Int(x1), y: Int(y0), width: image.width, height: image.height) {
            for c in 0..<P.channels {
                result[c] += x0x * yy1 * image[ru.x, ru.y, c]
            }
        } else if let constant = constant {
            result += x0x * yy1 * constant
        } else {
            fatalError("Never happens.")
        }
        
        if let ld = inImageCoord(x: Int(x0), y: Int(y1), width: image.width, height: image.height) {
            for c in 0..<P.channels {
                result[c] += xx1 * y0y * image[ld.x, ld.y, c]
            }
        } else if let constant = constant {
            result += xx1 * y0y * constant
        } else {
            fatalError("Never happens.")
        }
        
        if let rd = inImageCoord(x: Int(x1), y: Int(y1), width: image.width, height: image.height) {
            for c in 0..<P.channels {
                result[c] += x0x * y0y * image[rd.x, rd.y, c]
            }
        } else if let constant = constant {
            result += x0x * y0y * constant
        } else {
            fatalError("Never happens.")
        }
        
        // Equivalent code, but much slower.
        //
        // let lu = getPixel(x: Int(x0), y: Int(y0), in: image)
        // let ru = getPixel(x: Int(x1), y: Int(y0), in: image)
        // let ld = getPixel(x: Int(x0), y: Int(y1), in: image)
        // let rd = getPixel(x: Int(x1), y: Int(y1), in: image)
        //
        // var result = xx1 * yy1 * lu
        // result += x0x * yy1 * ru
        //
        // result += xx1 * y0y * ld
        // result += x0x * y0y * rd
        
        return result
    }
}
