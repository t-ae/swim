import Foundation

extension Image {
    @inlinable
    func getSubimage(x: Int, y: Int, width: Int, height: Int) -> Image<P, T> {
        assert(0 <= width && 0 <= height)
        precondition(0 <= x && 0 <= y, "Index out of range.")
        precondition(x+width <= self.width, "Index out of range.")
        precondition(y+height <= self.height, "Index out of range.")
        
        let start = index(x: x, y: y)
        
        var newImage = Image<P, T>(width: width, height: height)
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress! + start
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<height {
                    memcpy(dst, src, width*P.channels*MemoryLayout<T>.size)
                    src += self.width*P.channels
                    dst += width*P.channels
                }
            }
        }
        
        return newImage
    }
    
    @inlinable
    mutating func setSubimage(x: Int, y: Int, width: Int, height: Int, newValue: Image<P, T>) {
        precondition(0 <= x && 0 <= y, "Index out of range.")
        precondition(x+width <= self.width, "Index out of range.")
        precondition(y+height <= self.height, "Index out of range.")
        if width == 0 || height == 0 {
            // No effects
            return
        }
        precondition((width, height) == newValue.size,
                     "Invalid size: \((width, height)) != \(newValue.size)")
        
        let start = index(x: x, y: y)
        let baseWidth = self.width
        newValue.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress! + start
                for _ in 0..<height {
                    memcpy(dst, src, width*P.channels*MemoryLayout<T>.size)
                    src += width*P.channels
                    dst += baseWidth*P.channels
                }
            }
        }
    }
    
    @inlinable
    func getSubimage(xRange: Range<Int>, yRange: Range<Int>) -> Image<P, T> {
        let x = xRange.lowerBound
        let y = yRange.lowerBound
        let width = xRange.upperBound - x
        let height = yRange.upperBound - y
        
        return getSubimage(x: x, y: y, width: width, height: height)
    }
    
    @inlinable
    mutating func setSubimage(xRange: Range<Int>, yRange: Range<Int>, newValue: Image<P, T>) {
        let x = xRange.lowerBound
        let y = yRange.lowerBound
        let width = xRange.upperBound - x
        let height = yRange.upperBound - y
        
        setSubimage(x: x, y: y, width: width, height: height, newValue: newValue)
    }
}

extension Image {
    @inlinable
    public subscript(xRange: Range<Int>, yRange: Range<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    @inlinable
    public subscript(rows rows: Range<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    @inlinable
    public subscript(cols cols: Range<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
    
    @inlinable
    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    @inlinable
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}
