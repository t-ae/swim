extension Image {
    /// Create image mask.
    ///
    /// Result has same size as `self` and `mask[x, y] = body(self[x, y])`.
    @inlinable
    public func createMask(_ body: (Pixel<P, T>)->Bool) -> Image<Gray, Bool> {
        return unsafePixelwiseConverted { src, dst in
            dst[.gray] = body(src)
        }
    }
}
