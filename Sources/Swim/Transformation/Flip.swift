extension Image {
    /// Flip horizontally.
    @inlinable
    public func flipLR() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            for px in self.pixels() {
                let dstX = width - 1 - px.x
                let dstOffset = Image<P, T>.dataIndex(x: dstX, y: px.y,
                                                      width: width, height: height)
                let dst = UnsafeMutableBufferPointer(rebasing: $0[dstOffset..<dstOffset+P.channels])
                _ = dst.initialize(from: px.color.data)
            }
        }
    }
    
    /// Flip vertically.
    @inlinable
    public func flipUD() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var srcOffset = 0
            var dstOffset = Image<P, T>.dataIndex(x: 0, y: height-1, width: width, height: height)
            let rowCount = width * P.channels
            
            for  _ in 0..<height {
                let dst = UnsafeMutableBufferPointer(rebasing: $0[dstOffset..<dstOffset+rowCount])
                _ = dst.initialize(from: data[srcOffset..<srcOffset+rowCount])
                srcOffset += width*P.channels
                dstOffset -= width*P.channels
            }
        }
    }
}
