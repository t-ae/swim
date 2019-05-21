extension Image {
    /// Draw rectangle.
    @inlinable
    public mutating func drawRect(_ xRange: Range<Int>,
                                  _ yRange: Range<Int>,
                                  pixel: Pixel<P, T>) {
        drawRect(origin: (xRange.startIndex, yRange.startIndex),
                 size: (xRange.count, yRange.count),
                 pixel: pixel)
    }
    
    /// Draw rectangle.
    @inlinable
    public mutating func drawRect(origin: (x: Int, y: Int),
                                  size: (width: Int, height: Int),
                                  pixel: Pixel<P, T>) {
        let bottom = origin.y + size.height
        
        for y in origin.y..<bottom {
            drawHorizontalLine(x1: origin.x, x2: origin.x+size.width-1, y: y, pixel: pixel)
        }
    }
        
    /// Draw Rectangle pelimeter.
    @inlinable
    public mutating func drawRectPelimeter(origin: (x: Int, y: Int),
                                           size: (width: Int, height: Int),
                                           pixel: Pixel<P, T>) {
        
        let right = origin.x + size.width
        let bottom = origin.y + size.height
        
        drawLine(p1: (origin.x, origin.y), p2: (origin.x, bottom-1), pixel: pixel)
        drawLine(p1: (right, origin.y), p2: (right, bottom-1), pixel: pixel)
        
        drawHorizontalLine(x1: origin.x, x2: right-1, y: origin.y, pixel: pixel)
        drawHorizontalLine(x1: origin.x, x2: right-1, y: bottom, pixel: pixel)
    }
}
