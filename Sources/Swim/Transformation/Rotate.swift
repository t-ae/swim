extension Image {
    /// Rotate image by 90 degrees clockwise.
    @inlinable
    public func rot90() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: height, height: width) {
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: height - 1 - px.y, y: px.x,
                                                      width: height, height: width)
                let dst = UnsafeMutableBufferPointer(rebasing: $0[dstOffset..<dstOffset + P.channels])
                _ = dst.initialize(from: px.color.data)
            }
        }
    }
    
    /// Rotate image by 180 degrees clockwise.
    @inlinable
    public func rot180() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var srcOffset = 0
            var dstOffset = Image<P, T>.dataIndex(x: width-1, y: height-1, width: width, height: height)
            
            for _ in 0..<pixelCount {
                let src = data[srcOffset..<srcOffset+P.channels]
                let dst = UnsafeMutableBufferPointer(rebasing: $0[dstOffset..<dstOffset + P.channels])
                _ = dst.initialize(from: src)
                srcOffset += P.channels
                dstOffset -= P.channels
            }
        }
    }
    
    /// Rotate image by 270 degrees clockwise.
    @inlinable
    public func rot270() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: height, height: width) {
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: px.y, y: width - 1 - px.x, width: height, height: width)
                let dst = UnsafeMutableBufferPointer(rebasing: $0[dstOffset..<dstOffset + P.channels])
                _ = dst.initialize(from: px.color.data)
            }
        }
    }
}
