
public enum BayerPattern {
    case bggr, gbrg, grbg, rggb
}

extension BayerPattern {
    fileprivate var offsetToBGGR: (x: Int, y: Int) {
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

extension Image where P == RGB {
    func _bayered(pattern: BayerPattern) -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>(width: width, height: height)

        let (offsetX, offsetY) = pattern.offsetToBGGR

        for y in 0..<height {
            for x in 0..<width {
                let xOdd = (x+offsetX) % 2 != 0
                let yOdd = (y+offsetY) % 2 != 0

                switch (xOdd, yOdd) {
                case (true, true): // r
                    newImage[x, y] = self[x, y, .red]
                case (false, true), (true, false): // g
                    newImage[x, y] = self[x, y, .green]
                case (false, false): // b
                    newImage[x, y] = self[x, y, .blue]
                }
            }
        }

        return newImage
    }
    
    public func bayered(pattern: BayerPattern) -> Image<Intensity, T> {
        return _bayered(pattern: pattern)
    }
}

extension Image where P == Intensity, T: BinaryInteger {

    // type b,g,g,r <-> 0,1,2,3
    private func debayerPixel(x: Int, y: Int, type: Int) -> Pixel<RGB, T> {

        func mean(_ points: [(x: Int, y: Int)]) -> T {
            var sum: T = 0
            var count = 0
            for p in points {
                if 0 <= p.x && p.x < width && 0 <= p.y && p.y < height {
                    sum += self[p.x, p.y]
                    count += 1
                }
            }
            return sum / T(count)
        }

        let r, g, b: T
        switch type {
        case 0:
            r = mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
            g = mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            b = self[x, y]
        case 1:
            r = mean([(x, y-1), (x, y+1)])
            g = self[x, y]
            b = mean([(x-1, y), (x+1, y)])
        case 2:
            r = mean([(x-1, y), (x+1, y)])
            g = self[x, y]
            b = mean([(x, y-1), (x, y+1)])
        case 3:
            r = self[x, y]
            g = mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            b = mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
        default:
            preconditionFailure("Never reach here.")
        }
        return Pixel(r: r, g: g, b: b)
    }

    func _debayered(pattern: BayerPattern) -> Image<RGB, T> {
        var newImage = Image<RGB, T>(width: width, height: height)

        let (offsetX, offsetY) = pattern.offsetToBGGR

        for y in 0..<height {
            for x in 0..<width {
                let xOdd = (x+offsetX) % 2
                let yOdd = (y+offsetY) % 2

                let type = yOdd*2+xOdd
                newImage[x, y] = debayerPixel(x: x, y: y, type: type)
            }
        }

        return newImage
    }
    
    public func debayered(pattern: BayerPattern) -> Image<RGB, T> {
        return _debayered(pattern: pattern)
    }
}

extension Image where P == Intensity, T: FloatingPoint {
    
    // type b,g,g,r <-> 0,1,2,3
    private func debayerPixel(x: Int, y: Int, type: Int) -> Pixel<RGB, T> {
        
        func mean(_ points: [(x: Int, y: Int)]) -> T {
            var sum: T = 0
            var count = 0
            for p in points {
                if 0 <= p.x && p.x < width && 0 <= p.y && p.y < height {
                    sum += self[x, y]
                    count += 1
                }
            }
            return sum / T(count)
        }
        
        let r, g, b: T
        switch type {
        case 0:
            r = mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
            g = mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            b = self[x, y]
        case 1:
            r = mean([(x, y-1), (x, y+1)])
            g = self[x, y]
            b = mean([(x-1, y), (x+1, y)])
        case 2:
            r = mean([(x-1, y), (x+1, y)])
            g = self[x, y]
            b = mean([(x, y-1), (x, y+1)])
        case 3:
            r = self[x, y]
            g = mean([(x-1, y), (x+1, y), (x, y-1), (x, y+1)])
            b = mean([(x-1, y-1), (x+1, y-1), (x-1, y+1), (x+1, y+1)])
        default:
            preconditionFailure("Never reach here.")
        }
        return Pixel(r: r, g: g, b: b)
    }
    
    func _debayered(pattern: BayerPattern) -> Image<RGB, T> {
        var newImage = Image<RGB, T>(width: width, height: height)
        
        let (offsetX, offsetY) = pattern.offsetToBGGR
        
        for y in 0..<height {
            let yOdd = (y+offsetY) % 2
            for x in 0..<width {
                let xOdd = (x+offsetX) % 2
                
                let type = yOdd*2+xOdd
                newImage[x, y] = debayerPixel(x: x, y: y, type: type)
            }
        }
        
        return newImage
    }
    
    public func debayered(pattern: BayerPattern) -> Image<RGB, T> {
        return _debayered(pattern: pattern)
    }
}

extension Image where P == RGB, DT == UInt8 {
    public func bayered(pattern: BayerPattern) -> Image<Intensity, T> {
    return _bayered(pattern: pattern)
    }
}

extension Image where P == Intensity, DT == UInt8 {
    @available(*, deprecated, message: "Could cause overflow.")
    public func debayered(pattern: BayerPattern) -> Image<RGB, T> {
        return _debayered(pattern: pattern)
    }
}
