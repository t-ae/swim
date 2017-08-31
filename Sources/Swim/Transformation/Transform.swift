
import Foundation

extension Image {
    public func flipLR() -> Image<P, T> {
        
        var flippedData = [T](repeating: T.swimDefaultValue, count: width*height*P.channels)
        
        data.withUnsafeBufferPointer { src in
            flippedData.withUnsafeMutableBufferPointer { dst in
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
        
        return Image(width: width, height: height, data: flippedData)
    }
    
    public func flipUD() -> Image<P, T> {
        
        var flippedData = [T](repeating: T.swimDefaultValue, count: width*height*P.channels)
        
        data.withUnsafeBufferPointer { src in
            flippedData.withUnsafeMutableBufferPointer { dst in
                var src = src.baseAddress!
                var dst = dst.baseAddress! + (height-1)*width*P.channels
                for _ in 0..<height {
                    memcpy(dst, src, width * P.channels * MemoryLayout<T>.size)
                    src += width*P.channels
                    dst -= width*P.channels
                }
            }
        }
        
        return Image(width: width, height: height, data: flippedData)
    }
}

extension Image {
    func rot180() -> Image<P, T> {
        var rotData = [T](repeating: T.swimDefaultValue, count: self.data.count)
        
        data.withUnsafeBufferPointer { src in
            rotData.withUnsafeMutableBufferPointer { dst in
                var src = src.baseAddress!
                var dst = dst.baseAddress! + ((height-1) * width + width-1) * P.channels
                for _ in 0..<width*height {
                    memcpy(dst, src, width * P.channels * MemoryLayout<T>.size)
                    src += P.channels
                    dst -= P.channels
                }
            }
        }
        
        return Image(width: width, height: height, data: rotData)
    }
}
