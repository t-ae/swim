
import Foundation

extension Image {
    public func nearestNeighbor(x: Double, y: Double) -> Pixel<P, T> {
        assert(0 <= x && x <= Double(width-1))
        assert(0 <= y && y <= Double(height-1))
        
        let xx = Int(Foundation.round(x))
        let yy = Int(Foundation.round(y))
        
        return self[xx, yy]
    }
}
