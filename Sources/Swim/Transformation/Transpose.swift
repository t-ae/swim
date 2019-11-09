extension Image {
    /// Transpose image.
    @inlinable
    public func transposed() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: height, height: width) {
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: px.y, y: px.x, width: height, height: width)
                let dst = UnsafeMutableBufferPointer(rebasing: $0[dstOffset..<dstOffset + P.channels])
                _ = dst.initialize(from: px.color.data)
            }
        }
    }
}
