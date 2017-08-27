
import Foundation

extension Image {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            let x = xRange.lowerBound
            let y = yRange.lowerBound
            let width = xRange.upperBound - x
            let height = yRange.upperBound - y
            
            precondition(0 <= x && 0 <= y)
            precondition(x+width <= self.width)
            precondition(y+height <= self.height)
            
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
        set {
            let x = xRange.lowerBound
            let y = yRange.lowerBound
            let width = xRange.upperBound - x
            let height = yRange.upperBound - y
            
            precondition(0 <= x && 0 <= y)
            precondition(x+width <= self.width)
            precondition(y+height <= self.height)
            precondition(width == newValue.width)
            precondition(height == newValue.height)
            
            let start = index(x: x, y: y)
            
            newValue.data.withUnsafeBufferPointer {
                var src = $0.baseAddress!
                self.data.withUnsafeMutableBufferPointer {
                    var dst = $0.baseAddress! + start
                    for _ in 0..<height {
                        memcpy(dst, src, width*P.channels*MemoryLayout<T>.size)
                        src += width*P.channels
                        dst += self.width*P.channels
                    }
                }
            }
            
        }
    }
}

extension Image {
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}
