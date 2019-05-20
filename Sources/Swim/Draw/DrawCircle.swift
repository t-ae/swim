import Foundation

extension Image {
    /// Draw circle.
    @inlinable
    public mutating func drawCircle(center: (x: Int, y: Int),
                                    radius: Int,
                                    pixel: Pixel<P, T>) {
        var d = 1 - radius
        var dH = 3
        var dD = 5 - 2*radius
        
        var (x, y) = (0, radius)
        while x < y {
            if d < 0 {
                d += dH
                dH += 2
                dD += 2
            } else {
                d += dD
                dH += 2
                dD += 4
                y -= 1
            }
            
            self.drawLine(p1: (center.x-x, center.y+y), p2: (center.x+x, center.y+y), pixel: pixel)
            self.drawLine(p1: (center.x-y, center.y+x), p2: (center.x+y, center.y+x), pixel: pixel)
            self.drawLine(p1: (center.x-x, center.y-y), p2: (center.x+x, center.y-y), pixel: pixel)
            self.drawLine(p1: (center.x-y, center.y-x), p2: (center.x+y, center.y-x), pixel: pixel)
            x += 1
        }
    }
    
    /// Draw circle pelimeter.
    @inlinable
    public mutating func drawCirclePelimeter(center: (x: Int, y: Int),
                                             radius: Int,
                                             pixel: Pixel<P, T>) {
        var d = 1 - radius
        var dH = 3
        var dD = 5 - 2*radius
        
        var (x, y) = (0, radius)
        while x < y {
            if d < 0 {
                d += dH
                dH += 2
                dD += 2
            } else {
                d += dD
                dH += 2
                dD += 4
                y -= 1
            }
            
            self.drawPixel(x: center.x + x, y: center.y + y, pixel: pixel)
            self.drawPixel(x: center.x + y, y: center.y + x, pixel: pixel)
            self.drawPixel(x: center.x - x, y: center.y + y, pixel: pixel)
            self.drawPixel(x: center.x - y, y: center.y + x, pixel: pixel)
            self.drawPixel(x: center.x + x, y: center.y - y, pixel: pixel)
            self.drawPixel(x: center.x + y, y: center.y - x, pixel: pixel)
            self.drawPixel(x: center.x - x, y: center.y - y, pixel: pixel)
            self.drawPixel(x: center.x - y, y: center.y - x, pixel: pixel)
            
            x += 1
        }
    }
}
