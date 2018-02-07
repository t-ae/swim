
import Foundation

extension Image where T: BinaryFloatingPoint {
    func bilinearInterpolation(x: T, y: T) -> Pixel<P, T> {
        assert(0 <= x && x <= T(width-1))
        assert(0 <= y && y <= T(height-1))
        
        let xx = Int(x) // floor
        let xx1 = Int(Foundation.ceil(x))
        let yy = Int(y) // floor
        let yy1 = Int(Foundation.ceil(y))

        let yy1yp: T = T(yy+1) - y
        let ypyy: T = y - T(yy)

        // left two pixels
        let xx1xp: T = T(xx+1) - x
        let tmp = xx1xp * yy1yp // somehow can't compile without this
        var result: Pixel<P, T> = tmp * self[unsafe: xx, yy]
        result += (xx1xp * ypyy) * self[unsafe: xx, yy1]

        // right two pixels
        let xpxx: T = x - T(xx)
        result += (xpxx * yy1yp) * self[unsafe: xx1, yy]
        result += (xpxx * ypyy) * self[unsafe: xx1, yy1]

        return result
    }
}
