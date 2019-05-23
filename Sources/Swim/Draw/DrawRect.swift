extension Image {
    /// Draw rectangle.
    @inlinable
    public mutating func drawRect(_ xRange: Range<Int>,
                                  _ yRange: Range<Int>,
                                  color: Pixel<P, T>) {
        drawRect(origin: (xRange.startIndex, yRange.startIndex),
                 size: (xRange.count, yRange.count),
                 color: color)
    }
    
    /// Draw rectangle.
    @inlinable
    public mutating func drawRect(origin: (x: Int, y: Int),
                                  size: (width: Int, height: Int),
                                  color: Pixel<P, T>) {
        precondition(size.width >= 0, "size must be positive.")
        precondition(size.height >= 0, "size must be positive.")
        
        guard origin.x < width && origin.y < height else {
            // Drawing area is out of image.
            return
        }
        
        let bottom = origin.y + size.height
        
        for y in origin.y..<bottom {
            drawHorizontalLine(x1: origin.x, x2: origin.x+size.width-1, y: y, color: color)
        }
    }
    
    /// Draw rectangle pelimeter.
    @inlinable
    public mutating func drawRectPelimeter(_ xRange: Range<Int>,
                                           _ yRange: Range<Int>,
                                           color: Pixel<P, T>) {
        drawRectPelimeter(origin: (xRange.startIndex, yRange.startIndex),
                          size: (xRange.count, yRange.count),
                          color: color)
    }
        
    /// Draw rectangle pelimeter.
    @inlinable
    public mutating func drawRectPelimeter(origin: (x: Int, y: Int),
                                           size: (width: Int, height: Int),
                                           color: Pixel<P, T>) {
        precondition(size.width >= 0, "size must be positive.")
        precondition(size.height >= 0, "size must be positive.")
        
        guard origin.x < width && origin.y < height else {
            // Drawing area is out of image.
            return
        }
        
        let right = origin.x + size.width
        let bottom = origin.y + size.height
        
        drawLine(p1: (origin.x, origin.y), p2: (origin.x, bottom-1), color: color)
        drawLine(p1: (right-1, origin.y), p2: (right-1, bottom-1), color: color)
        
        drawHorizontalLine(x1: origin.x, x2: right-1, y: origin.y, color: color)
        drawHorizontalLine(x1: origin.x, x2: right-1, y: bottom-1, color: color)
    }
}
