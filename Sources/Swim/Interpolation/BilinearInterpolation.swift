
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

        // interpolate left two pixels
        var pl: Pixel<P, T> = yy1yp * self[unsafe: xx, yy]
        pl += ypyy * self[unsafe: xx, yy1]

        // interpolate right two pixels
        var pr: Pixel<P, T> = yy1yp * self[unsafe: xx1, yy]
        pr += ypyy * self[unsafe: xx1, yy1]

        // interpolate two pixel
        let xx1xp: T = T(xx+1) - x
        pl *= xx1xp
        let xpxx: T = x - T(xx)
        pr *= xpxx

        return pl + pr
    }
}
