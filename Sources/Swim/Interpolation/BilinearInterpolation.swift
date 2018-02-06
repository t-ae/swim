
import Foundation

extension Image where T: BinaryFloatingPoint {
    func bilinearInterpolation(x: T, y: T) -> Pixel<P, T> {
        assert(0 <= x && x <= T(width-1))
        assert(0 <= y && y <= T(height-1))
        
        let xx = Int(Foundation.floor(x))
        let xx1 = Int(Foundation.ceil(x))
        let yy = Int(Foundation.floor(y))
        let yy1 = Int(Foundation.ceil(y))
        let xx1xp: T = T(xx+1) - x
        let xpxx: T = x - T(xx)
        let yy1yp: T = T(yy+1) - y
        let ypyy: T = y - T(yy)
        
        let plu: Pixel<P, T> = yy1yp * self[xx, yy]
        let pru: Pixel<P, T> = ypyy * self[xx, yy1]
        let pu: Pixel<P, T> = plu + pru
        
        let pld: Pixel<P, T> = yy1yp * self[xx1, yy]
        let prd: Pixel<P, T> = ypyy * self[xx1, yy1]
        let pd: Pixel<P, T> = pld + prd
        
        let px1: Pixel<P, T> = xx1xp * pu
        let px2: Pixel<P, T> = xpxx * pd
        
        return px1 + px2
    }
}
