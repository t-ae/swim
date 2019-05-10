public struct BayerConverter {
    public enum Pattern {
        case bggr, gbrg, grbg, rggb
    }
    
    public var pattern: Pattern
    
    public init(pattern: Pattern) {
        self.pattern = pattern
    }
}

extension BayerConverter.Pattern {
    @inlinable
    var offsetToBGGR: (x: Int, y: Int) {
        switch self {
        case .bggr:
            return (0, 0)
        case .gbrg:
            return (1, 0)
        case .grbg:
            return (0, 1)
        case .rggb:
            return (1, 1)
        }
    }
}

extension BayerConverter {
    /// Convert color image to bayer format.
    @inlinable
    public func convert<T>(image: Image<RGB, T>) -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>(width: image.width, height: image.height)
        
        let (offsetX, offsetY) = pattern.offsetToBGGR
        
        var yOdd = offsetY % 2 != 0
        for y in 0..<image.height {
            var xOdd = offsetX % 2 != 0
            for x in 0..<image.width {
                switch (xOdd, yOdd) {
                case (true, true): // r
                    newImage[x, y, .intensity] = image[x, y, .red]
                case (false, true), (true, false): // g
                    newImage[x, y, .intensity] = image[x, y, .green]
                case (false, false): // b
                    newImage[x, y, .intensity] = image[x, y, .blue]
                }
                
                xOdd.toggle()
            }
            
            yOdd.toggle()
        }
        
        return newImage
    }
}

extension BayerConverter {
    /// Reconstruct color image from bayer format image.
    @inlinable
    public func demosaic<T: BinaryInteger>(image: Image<Intensity, T>) -> Image<RGB, T> {
        let (offsetX, offsetY) = pattern.offsetToBGGR
        
        var newImage = Image<RGB, T>(width: image.width, height: image.height)
        
        func mean(_ points: [(x: Int, y: Int)]) -> T {
            var sum: T = 0
            var count = 0
            for p in points {
                if 0 <= p.x && p.x < image.width && 0 <= p.y && p.y < image.height {
                    sum += image[p.x, p.y, .intensity]
                    count += 1
                }
            }
            return sum / T(count)
        }
        
        func getPixelValue(x: Int, y: Int, channel: RGB) -> T {
            let xOdd = (x + offsetX) % 2 == 1
            let yOdd = (y + offsetY) % 2 == 1
            
            switch (xOdd, yOdd, channel) {
            case (false, false, .red):
                return mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
            case (false, false, .green):
                return mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            case (false, false, .blue):
                return image[x, y]
            case (true, false, .red):
                return mean([(x, y-1), (x, y+1)])
            case (true, false, .green):
                return image[x, y]
            case (true, false, .blue):
                return mean([(x-1, y), (x+1, y)])
            case (false, true, .red):
                return mean([(x-1, y), (x+1, y)])
            case (false, true, .green):
                return image[x, y]
            case (false, true, .blue):
                return mean([(x, y-1), (x, y+1)])
            case (true, true, .red):
                return image[x, y]
            case (true, true, .green):
                return mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            case (true, true, .blue):
                return mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
            }
        }
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                newImage[x, y, .red] = getPixelValue(x: x, y: y, channel: .red)
                newImage[x, y, .green] = getPixelValue(x: x, y: y, channel: .green)
                newImage[x, y, .blue] = getPixelValue(x: x, y: y, channel: .blue)
            }
        }
        
        return newImage
    }
    
    /// Reconstruct color image from bayer format image.
    @inlinable
    public func demosaic<T: BinaryFloatingPoint>(image: Image<Intensity, T>) -> Image<RGB, T> {
        let (offsetX, offsetY) = pattern.offsetToBGGR
        
        var newImage = Image<RGB, T>(width: image.width, height: image.height)
        
        func mean(_ points: [(x: Int, y: Int)]) -> T {
            var sum: T = 0
            var count = 0
            for p in points {
                if 0 <= p.x && p.x < image.width && 0 <= p.y && p.y < image.height {
                    sum += image[p.x, p.y, .intensity]
                    count += 1
                }
            }
            return sum / T(count)
        }
        
        func getPixelValue(x: Int, y: Int, channel: RGB) -> T {
            let xOdd = (x + offsetX) % 2 == 1
            let yOdd = (y + offsetY) % 2 == 1
            
            switch (xOdd, yOdd, channel) {
            case (false, false, .red):
                return mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
            case (false, false, .green):
                return mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            case (false, false, .blue):
                return image[x, y]
            case (true, false, .red):
                return mean([(x, y-1), (x, y+1)])
            case (true, false, .green):
                return image[x, y]
            case (true, false, .blue):
                return mean([(x-1, y), (x+1, y)])
            case (false, true, .red):
                return mean([(x-1, y), (x+1, y)])
            case (false, true, .green):
                return image[x, y]
            case (false, true, .blue):
                return mean([(x, y-1), (x, y+1)])
            case (true, true, .red):
                return image[x, y]
            case (true, true, .green):
                return mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            case (true, true, .blue):
                return mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
            }
        }
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                newImage[x, y, .red] = getPixelValue(x: x, y: y, channel: .red)
                newImage[x, y, .green] = getPixelValue(x: x, y: y, channel: .green)
                newImage[x, y, .blue] = getPixelValue(x: x, y: y, channel: .blue)
            }
        }
        
        return newImage
    }
}
