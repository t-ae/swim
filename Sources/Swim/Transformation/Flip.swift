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
        var newImage = Image<P, T>(width: width, height: height)
        
        data.withUnsafeBufferPointer { src in
            newImage.data.withUnsafeMutableBufferPointer { dst in
                var src = src.baseAddress!
                var dst = dst.baseAddress! + (height-1)*width*P.channels
                for _ in 0..<height {
                    memcpy(dst, src, width * P.channels * MemoryLayout<T>.size)
                    src += width*P.channels
                    dst -= width*P.channels
                }
            }
        }
        
        return newImage
    }
}
