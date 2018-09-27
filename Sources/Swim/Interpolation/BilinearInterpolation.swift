import Foundation

extension Image where T: BinaryFloatingPoint {
    /// - Preconditions:
    ///   - 0 <= x < width
    ///   - 0 <= y < height
    func interpolateBilinear(x: T, y: T) -> Pixel<P, T> {
        precondition(0 <= x && x < T(width))
        precondition(0 <= y && y < T(height))
        
        // area
        let x0x = x + 0.5 - Foundation.round(x)
        let y0y = y + 0.5 - Foundation.round(y)
        let xx1 = 1 - x0x
        let yy1 = 1 - y0y
        
        // pixel coord
        let lx = max(Int(x-0.5), 0)
        let rx = min(Int(Foundation.round(x)), width-1)
        let uy = max(Int(y-0.5), 0)
        let dy = min(Int(Foundation.round(y)), height-1)

        // left two pixels
        let tmp = xx1 * yy1 // somehow can't compile without this
        var result: Pixel<P, T> = tmp * self[unsafe: lx, uy]
        result += (xx1 * y0y) * self[unsafe: lx, dy]

        // right two pixels
        result += (x0x * yy1) * self[unsafe: rx, uy]
        result += (x0x * y0y) * self[unsafe: rx, dy]

        return result
    }
}
