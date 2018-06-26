import Foundation

extension Image {
    /// - Preconditions:
    ///   - 0 <= x < width
    ///   - 0 <= y < height
    func nearestNeighbor<F: BinaryFloatingPoint>(x: F, y: F) -> Pixel<P, T> {
        assert(0 <= x && x < F(width))
        assert(0 <= y && y < F(height))
        
        let xx = Int(x)
        let yy = Int(y)
        
        return self[unsafe: xx, yy]
    }
}
