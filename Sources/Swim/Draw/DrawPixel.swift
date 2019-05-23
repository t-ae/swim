extension Image {
    /// Draw single pixel.
    ///
    /// If specified point is outside of image, this method does nothing.
    @inlinable
    public mutating func drawPixel(x: Int, y: Int, color: Pixel<P, T>) {
        guard 0 <= x && x < width && 0 <= y && y < height else {
            return
        }
        self[x, y] = color
    }
}
