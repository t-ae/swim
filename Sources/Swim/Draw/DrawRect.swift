extension Image {
    @inlinable
    public mutating func drawRect(origin: (x: Int, y: Int),
                                  size: (width: Int, height: Int),
                                  pixel: Pixel<P, T>) {
        
        let right = origin.x + size.width - 1
        let bottom = origin.y + size.height - 1
        
        for y in origin.y...bottom {
            self.drawPixel(x: origin.x, y: y, pixel: pixel)
            self.drawPixel(x: right, y: y, pixel: pixel)
        }
        for x in origin.x...right {
            self.drawPixel(x: x, y: origin.y, pixel: pixel)
            self.drawPixel(x: x, y: bottom, pixel: pixel)
        }
    }
}
