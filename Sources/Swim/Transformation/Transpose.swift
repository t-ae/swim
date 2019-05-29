import Foundation

extension Image {
    
    // TODO: Add transpose when width/height become var.
    
    @inlinable
    public func transposed() -> Image<P, T> {
        return Image.createWithUnsafeMutableBufferPointer(width: height, height: width) {
            var dst = $0.baseAddress!
            
            data.withUnsafeBufferPointer {
                var src = $0.baseAddress!
                
                for _ in 0..<height {
                    var dst2 = dst
                    for _ in 0..<width {
                        memcpy(dst2, src, P.channels * MemoryLayout<T>.size)
                        src  += P.channels
                        dst2 += height * P.channels
                    }
                    dst += P.channels
                }
            }
        }
    }
}
