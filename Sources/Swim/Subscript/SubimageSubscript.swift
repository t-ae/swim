import Foundation

extension Image {
    @inlinable
    func getSubimage(x: Int, y: Int, width: Int, height: Int) -> Image<P, T> {
        assert(0 <= width && 0 <= height)
        precondition(0 <= x && 0 <= y, "Index out of range.")
        precondition(x+width <= self.width, "Index out of range.")
        precondition(y+height <= self.height, "Index out of range.")
        
        let start = dataIndex(x: x, y: y)
        
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
            for y in 0..<height {
                copy(src: data, srcOffset: start + y*self.width*P.channels,
                     dst: dst, dstOffset: y*width*P.channels, count: width*P.channels)
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
            copy(src: newValue.data, srcOffset: y*width*P.channels,
                 dst: &data, dstOffset: start + y*self.width*P.channels,
                 count: width*P.channels)
        }
    }
}

extension Image {
    /// Access the subimage in specified rect.
    ///
    /// The complexity is `O(rect.width*rect.height)`.
    @inlinable
    public subscript(rect: Rect) -> Image<P, T> {
        get {
            return getSubimage(x: rect.x, y: rect.y, width: rect.width, height: rect.height)
        }
        set {
            setSubimage(x: rect.x, y: rect.y, width: rect.width, height: rect.height, newValue: newValue)
        }
    }
    
    /// Access the subimage in specified range.
    ///
    /// The complexity is `O(xRange.count*yRange.count)`.
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
    
    /// Access the subimage in specified range.
    ///
    /// The complexity is `O(width*rows.count)`.
    @inlinable
    public subscript(rows rows: Range<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    /// Access the subimage in specified range.
    ///
    /// The complexity is `O(cols.count*height)`.
    @inlinable
    public subscript(cols cols: Range<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
    
    /// Access the subimage in specified range.
    ///
    /// The complexity is `O(width)`.
    @inlinable
    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    /// Access the subimage in specified range.
    ///
    /// The complexity is `O(height)`.
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
