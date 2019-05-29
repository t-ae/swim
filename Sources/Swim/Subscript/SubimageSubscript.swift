import Foundation

extension Image {
    @inlinable
    func getSubimage(x: Int, y: Int, width: Int, height: Int) -> Image<P, T> {
        assert(0 <= width && 0 <= height)
        precondition(0 <= x && 0 <= y, "Index out of range.")
        precondition(x+width <= self.width, "Index out of range.")
        precondition(y+height <= self.height, "Index out of range.")
        
        let start = dataIndex(x: x, y: y)
        
        return Image.createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            data.withUnsafeBufferPointer { src in
                for y in 0..<height {
                    strideCopy(src: src, srcOffset: start + y*self.width*P.channels, srcStride: 1,
                               dst: dst, dstOffset: y*width*P.channels, dstStride: 1,
                               count: width*P.channels)
                }
            }
        }
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
        
        let start = dataIndex(x: x, y: y)
        
        for y in 0..<height {
            strideCopy(src: newValue.data, srcOffset: y*width*P.channels, srcStride: 1,
                       dst: &data, dstOffset: start + y*self.width*P.channels, dstStride: 1,
                       count: width*P.channels)
        }
    }
}

extension Image {
    @inlinable
    public subscript(rect: Rect) -> Image<P, T> {
        get {
            return getSubimage(x: rect.x, y: rect.y, width: rect.width, height: rect.height)
        }
        set {
            setSubimage(x: rect.x, y: rect.y, width: rect.width, height: rect.height, newValue: newValue)
        }
    }
    
    
    @inlinable
    public subscript(xRange: Range<Int>, yRange: Range<Int>) -> Image<P, T> {
        get {
            let x = xRange.lowerBound
            let y = yRange.lowerBound
            
            return getSubimage(x: x, y: y, width: xRange.count, height: yRange.count)
        }
        set {
            let x = xRange.lowerBound
            let y = yRange.lowerBound
            
            setSubimage(x: x, y: y, width: xRange.count, height: yRange.count, newValue: newValue)
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
