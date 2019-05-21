extension Image {
    @inlinable
    mutating func drawHorizontalLine(x1: Int, x2: Int, y: Int, pixel: Pixel<P, T>) {
        guard 0 <= y && y < height else {
            return
        }
        
        let left = max(min(x1, x2), 0)
        let right = min(max(x1, x2) + 1, width)
        
        
        if left > width || right < 0 {
            return
        }
        
        pixelwiseConvert(left..<right, y..<y+1) { ref in
            ref.assign(pixel: pixel)
        }
    }
    
    /// Draw line between specified points.
    @inlinable
    public mutating func drawLine(p1: (x: Int, y: Int),
                                  p2: (x: Int, y: Int),
                                  pixel: Pixel<P, T>) {
        let dx = Swift.abs(p1.x - p2.x)
        let dy = Swift.abs(p1.y - p2.y)
        let sx = p1.x < p2.x ? 1 : -1
        let sy = p1.y < p2.y ? 1 : -1
        
        var error = dx - dy
        
        var (x, y) = p1
        while (x ,y) != p2 {
            drawPixel(x: x, y: y, pixel: pixel)
            
            let e2 = error*2
            if e2 > -dy {
                error -= dy
                x += sx
            }
            if e2 < dx {
                error += dx
                y += sy
            }
        }
        
        // draw p2
        self.drawPixel(x: x, y: y, pixel: pixel)
    }
    
    /// Draw line between specified points.
    /// - Parameters:
    ///   - close: It true, draw line between first and last points. Default: true.
    @inlinable
    public mutating func drawLines(points: [(x: Int, y: Int)],
                                   pixel: Pixel<P, T>,
                                   close: Bool = true) {
        guard points.count > 1 else {
            return
        }
        for i in 1..<points.count {
            drawLine(p1: points[i-1], p2: points[i], pixel: pixel)
        }
        
        if close {
            drawLine(p1: points[0], p2: points.last!, pixel: pixel)
        }
    }
    
    /// Draw cross mark at the specified point.
    @inlinable
    public mutating func drawX(center: (x: Int, y: Int), size: Int, pixel: Pixel<P, T>) {
        let length = size / 2
        
        let left = center.x - length
        let right = center.x + length
        let top = center.y - length
        let bottom = center.y + length
        
        drawLine(p1: (left, top), p2: (right, bottom), pixel: pixel)
        drawLine(p1: (left, bottom), p2: (right, top), pixel: pixel)
    }
}
