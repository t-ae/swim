import Foundation

extension Image {
    @inlinable
    public func flipLR() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: width - 1 - px.x, y: px.y, width: width, height: height)
                px.color.withUnsafeBufferPointer { bp in
                    copy(src: bp, dst: dst, dstOffset: dstOffset, count: P.channels)
                }
            }
        }
    }
    
    @inlinable
    public func flipUD() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            var srcOffset = 0
            var dstOffset = Image<P, T>.dataIndex(x: 0, y: height-1, width: width, height: height)
            
            for  _ in 0..<height {
                copy(src: data, srcOffset: srcOffset,
                     dst: dst, dstOffset: dstOffset, count: width*P.channels)
                srcOffset += width*P.channels
                dstOffset -= width*P.channels
            }
        }
    }
}
