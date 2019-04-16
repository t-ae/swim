import Foundation

// MARK: - Flip
extension Image {
    @inlinable
    public func flipLR() -> Image<P, T> {
        
        var newImage = Image<P, T>(width: width, height: height)
        
        data.withUnsafeBufferPointer { src in
            newImage.data.withUnsafeMutableBufferPointer { dst in
                let dstTail = dst.baseAddress! + (width-1)*P.channels
                for y in 0..<height {
                    var src = src.baseAddress! + y*width*P.channels
                    var dst = dstTail + y*width*P.channels
                    for _ in 0..<width {
                        memcpy(dst, src, P.channels * MemoryLayout<T>.size)
                        src += P.channels
                        dst -= P.channels
                    }
                }
            }
        }
        
        return newImage
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

// MARK: - Rotate
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
