
import Foundation

extension Image {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        let x = xRange.lowerBound
        let y = yRange.lowerBound
        let width = xRange.upperBound - x
        let height = yRange.upperBound - y
        
        let start = index(x: x, y: y)
        
        var data = [T](repeating: 0, count: width*height*P.channels)
        self.data.withUnsafeBufferPointer {
            var src = $0.baseAddress! + start
            data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<height {
                    memcpy(dst, src, width*P.channels*MemoryLayout<T>.size)
                    src += self.width*P.channels
                    dst += width*P.channels
                }
            }
        }
        
        return Image(width: width, height: height , data: data)
    }
}

extension Image {
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        return self[0..<width, rows]
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        return self[cols, 0..<height]
    }
}
