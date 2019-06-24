extension Image {
    /// Rotate image by 90 degrees clockwise.
    @inlinable
    public func rot90() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: height, height: width) { dst in
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: height - 1 - px.y, y: px.x, width: height, height: width)
                
                px.withUnsafeBufferPointer { bp in
                    copy(src: bp, dst: dst, dstOffset: dstOffset, count: P.channels)
                }
            }
        }
    }
    
    /// Rotate image by 180 degrees clockwise.
    @inlinable
    public func rot180() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            var srcOffset = 0
            var dstOffset = Image<P, T>.dataIndex(x: width-1, y: height-1, width: width, height: height)
            
            for _ in 0..<pixelCount {
                copy(src: data, srcOffset: srcOffset, dst: dst, dstOffset: dstOffset, count: P.channels)
                srcOffset += P.channels
                dstOffset -= P.channels
            }
        }
    }
    
    /// Rotate image by 270 degrees clockwise.
    @inlinable
    public func rot270() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: height, height: width) { dst in
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: px.y, y: width - 1 - px.x, width: height, height: width)
                
                px.withUnsafeBufferPointer { bp in
                    copy(src: bp, dst: dst, dstOffset: dstOffset, count: P.channels)
                }
            }
        }
    }
}
