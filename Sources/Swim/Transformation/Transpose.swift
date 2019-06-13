import Foundation

extension Image {
    
    // TODO: Add transpose when width/height become var.
    
    /// Transpose image.
    @inlinable
    public func transposed() -> Image<P, T> {
        return .createWithUnsafeMutableBufferPointer(width: height, height: width) { dst in
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: px.y, y: px.x, width: height, height: width)
                
                px.withUnsafeBufferPointer { bp in
                    copy(src: bp, srcOffset: 0, dst: dst, dstOffset: dstOffset, count: P.channels)
                }
            }
        }
    }
}
