import Foundation

extension Image {
    @inlinable
    public func rot90() -> Image<P, T> {
        var newImage = Image<P, T>(width: height, height: width)
        
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress! + (height - 1)*P.channels
                for _ in 0..<height {
                    var dst2 = dst
                    for _ in 0..<width {
                        memcpy(dst2, src, P.channels * MemoryLayout<T>.size)
                        src  += P.channels
                        dst2 += height * P.channels
                    }
                    dst -= P.channels
                }
            }
        }
        
        return newImage
    }
    
    @inlinable
    public func rot180() -> Image<P, T> {
        var newImage = Image<P, T>(width: width, height: height)
        
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress! + (pixelCount-1) * P.channels
                for _ in 0..<pixelCount {
                    memcpy(dst, src, P.channels * MemoryLayout<T>.size)
                    src += P.channels
                    dst -= P.channels
                }
            }
        }
        
        return newImage
    }
    
    @inlinable
    public func rot270() -> Image<P, T> {
        var newImage = Image<P, T>(width: height, height: width)
        
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<height {
                    var dst2 = dst + (width-1)*height*P.channels
                    for _ in 0..<width {
                        memcpy(dst2, src, P.channels * MemoryLayout<T>.size)
                        src  += P.channels
                        dst2 -= height * P.channels
                    }
                    dst += P.channels
                }
            }
        }
        return newImage
    }
}
