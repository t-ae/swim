extension Image {
    /// Create image mask.
    ///
    /// Result has same size as `self` and `mask[x, y] = f(self[x, y])`.
    ///
    /// - Note: `*PixelRef` contains `Unsafe*BufferPointer`. So it's unsafe to bring them outside closure.
    @inlinable
    public func createMask(_ f: (PixelRef<P, T>)->Bool) -> Image<Gray, Bool> {
        return pixelwiseConverted { src, dst in
            dst[.gray] = f(src)
        }
    }
}
