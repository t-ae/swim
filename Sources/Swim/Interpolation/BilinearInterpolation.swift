
import Foundation

extension Image where T: BinaryFloatingPoint {
    func bilinearInterpolation(x: T, y: T) -> Pixel<P, T> {
        assert(0 <= x && x <= T(width-1))
        assert(0 <= y && y <= T(height-1))
        
        let x0 = Int(x) // floor
        let x1 = Int(Foundation.ceil(x))
        let y0 = Int(y) // floor
        let y1 = Int(Foundation.ceil(y))

        let y1y: T = T(y0+1) - y
        let yy0: T = y - T(y0)

        // left two pixels
        let x1x: T = T(x0+1) - x
        let tmp = x1x * y1y // somehow can't compile without this
        var result: Pixel<P, T> = tmp * self[unsafe: x0, y0]
        result += (x1x * yy0) * self[unsafe: x0, y1]

        // right two pixels
        let xx0: T = x - T(x0)
        result += (xx0 * y1y) * self[unsafe: x1, y0]
        result += (xx0 * yy0) * self[unsafe: x1, y1]

        return result
    }
}
