import Foundation

extension Image {
    @inlinable
    public func rot90() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: height, height: width) { dst in
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: height - 1 - px.y, y: px.x, width: height, height: width)
                
                px.color.withUnsafeBufferPointer { bp in
                    copy(src: bp, dst: dst, dstOffset: dstOffset, count: P.channels)
                }
            }
        }
    }
    
    @inlinable
    public func rot180() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            var srcOffset = 0
            var dstOffset = Image<P, T>.dataIndex(x: width-1, y: height-1, width: width, height: height)
            
            for _ in 0..<pixelCount {
                copy(src: data, srcOffset: srcOffset, dst: dst, dstOffset: dstOffset, count: P.channels)
                srcOffset += P.channels
                dstOffset -= P.channels
            }
        }
    }
    
    @inlinable
    public func rot270() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: height, height: width) { dst in
            for px in self.pixels() {
                let dstOffset = Image<P, T>.dataIndex(x: px.y, y: width - 1 - px.x, width: height, height: width)
                
                px.color.withUnsafeBufferPointer { bp in
                    copy(src: bp, dst: dst, dstOffset: dstOffset, count: P.channels)
                }
            }
        }
    }
}
