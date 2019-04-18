import Foundation

public struct BilinearInterpolator<T: BinaryFloatingPoint&DataType>: Interpolator {
    public var mode: InterpolationMode<T>
    
    public init(mode: InterpolationMode<T> = .constant(0)) {
        self.mode = mode
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
        
        let lu = getPixel(x: x0, y: y0, in: image)
        let ru = getPixel(x: x1, y: y0, in: image)
        let ld = getPixel(x: x0, y: y1, in: image)
        let rd = getPixel(x: x1, y: y1, in: image)
        
        var top = xx1 * lu
        top += x0x * ru
        
        var bottom = xx1 * ld
        bottom += x0x * rd
        
        return top * yy1 + bottom * y0y
    }
}
