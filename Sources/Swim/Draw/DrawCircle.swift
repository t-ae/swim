import Foundation

extension Image {
    @inlinable
    public mutating func drawCircle(center: (x: Int, y: Int),
                                    radius: Int,
                                    pixel: Pixel<P, T>) {
        pixelwiseConvert { ref in
            let dx = ref.x - center.x
            let dy = ref.y - center.y
            
            if dx*dx + dy*dy <= radius*radius {
                ref.assign(pixel: pixel)
            }
        }
    }
    
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
