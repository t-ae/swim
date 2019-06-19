extension Image {
    /// Draw single pixel.
    ///
    /// If specified point is outside of image, this method does nothing.
    ///
    /// - Note: This method doesn't support alpha blending.
    @inlinable
    public mutating func drawPixel(x: Int, y: Int, color: Color<P, T>) {
        guard 0 <= x && x < width && 0 <= y && y < height else {
            return
        }
        self[x, y] = color
    }
}
