
import Foundation

extension Image {
    public func nearestNeighbor<F: BinaryFloatingPoint>(x: F, y: F) -> Pixel<P, T> {
        assert(0 <= x && x <= F(width-1))
        assert(0 <= y && y <= F(height-1))
        
        let xx = Int(Foundation.round(x))
        let yy = Int(Foundation.round(y))
        
        return self[xx, yy]
    }
}
