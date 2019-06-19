extension Image {
    /// Draw polygon.
    ///
    /// - Precondition: `points.count >= 3`
    ///
    /// - Note: This method doesn't support alpha blending.
    @inlinable
    public mutating func drawPolygon(points: [(x: Int, y: Int)], color: Color<P, T>) {
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
        
        func countRightCross(x: Int, y: Int) -> Int {
            var count = 0
            var j = points.count - 1
            for i in 0..<points.count {
                let pi = points[j]
                let pj = points[i]
                
                // Project line from (x, y) to right.
                if pi.y <= y && y < pj.y
                    && (x - pi.x) * (pj.y - pi.y) < (pj.x - pi.x) * (y - pi.y) {
                    count += 1
                } else if pj.y <= y && y < pi.y
                    && (x - pi.x) * (pj.y - pi.y) > (pj.x - pi.x) * (y - pi.y) {
                    count += 1
                }
                
                j = i
            }
            return count
        }
        
        for y in minY...maxY {
            var start = minX
            
            let maxXValue = countRightCross(x: maxX, y: y)
            
            while start <= maxX {
                let startValue = countRightCross(x: start, y: y)
                
                // Cross conut is odd iff (x, y) is inside polygon.
                let inside = startValue % 2 == 1
                
                if startValue == maxXValue {
                    if inside {
                        // All pixels btw start & maxX is inside polygon
                        drawHorizontalLine(x1: start, x2: maxX, y: y, color: color)
                    }
                    // end search
                    break
                } else if (start + maxX) / 2 == start {
                    if inside {
                        // Single pixel
                        drawPixel(x: start, y: y, color: color)
                    }
                    start += 1
                } else {
                    // Binary search
                    var left = start
                    var right = maxX
                    
                    while true {
                        let mid = (left + right) / 2
                        if mid == left {
                            if inside {
                                // All pixels btw start & left is inside polygon
                                drawHorizontalLine(x1: start, x2: left, y: y, color: color)
                            }
                            start = left + 1
                            break
                        }
                        let midValue = countRightCross(x: mid, y: y)
                        
                        if midValue == startValue {
                            left = mid
                        } else {
                            right = mid
                        }
                    }
                }
            }
        }
    }
    
    /// Draw polygon pelimeter.
    ///
    /// Same as `drawLines` with `close: true`.
    ///
    /// - Note: This method doesn't support alpha blending.
    @inlinable
    public mutating func drawPolygonPelimeter(points: [(x: Int, y: Int)], color: Color<P, T>) {
        drawLines(points: points, close: true, color: color)
    }
}
