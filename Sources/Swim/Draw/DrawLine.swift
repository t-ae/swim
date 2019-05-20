import Foundation

extension Image {
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
            self.drawPixel(x: x, y: y, pixel: pixel)
            
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
        self[x, y] = pixel
    }
    
    
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
}
