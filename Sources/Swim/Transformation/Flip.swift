import Foundation

extension Image {
    @inlinable
    public func flipLR() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            var srcOffset = 0
            for y in 0..<height {
                var dstOffset = (y+1)*width*P.channels - P.channels
                for _ in 0..<width {
                    copy(src: data, srcOffset: srcOffset,
                         dst: dst, dstOffset: dstOffset, count: P.channels)
                    srcOffset += P.channels
                    dstOffset -= P.channels
                }
            }
        }
    }
    
    @inlinable
    public func flipUD() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            var srcOffset = 0
            var dstOffset = (height-1)*width*P.channels
            for  _ in 0..<height {
                copy(src: data, srcOffset: srcOffset,
                     dst: dst, dstOffset: dstOffset, count: width*P.channels)
                srcOffset += width*P.channels
                dstOffset -= width*P.channels
            }
        }
    }
}
