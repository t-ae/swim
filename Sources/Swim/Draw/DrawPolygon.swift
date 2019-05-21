extension Image {
    @inlinable
    public mutating func drawPolygon(points: [(x: Int, y: Int)], pixel: Pixel<P, T>) {
        precondition(points.count >= 3, "Needs at least 3 points.")
        
        var minX = Int.max
        var maxX = Int.min
        var minY = Int.max
        var maxY = Int.min
        
        for p in points {
            minX = min(p.x, minX)
            maxX = max(p.x, maxX)
            minY = min(p.y, minY)
            maxY = max(p.y, maxY)
        }
        
        minX = max(minX, 0)
        maxX = min(maxX, width-1)
        minY = max(minY, 0)
        maxY = min(maxY, height-1)
        
        pixelwiseConvert(minX..<maxX+1, minY..<maxY+1) { ref in
            var j = points.count - 1
            
            var inside = false
            
            for i in 0..<points.count {
                let pi = points[j]
                let pj = points[i]
                
                if pi.y <= ref.y && ref.y < pj.y
                    && (ref.x - pi.x) * (pj.y - pi.y) < (pj.x - pi.x) * (ref.y - pi.y) {
                    inside.toggle()
                } else if pj.y <= ref.y && ref.y < pi.y
                    && (ref.x - pi.x) * (pj.y - pi.y) > (pj.x - pi.x) * (ref.y - pi.y) {
                    inside.toggle()
                }
                
                j = i
            }
            
            if inside {
                ref.assign(pixel: pixel)
            }
        }
    }
}
