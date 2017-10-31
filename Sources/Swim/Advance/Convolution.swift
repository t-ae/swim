
public enum Filter<T: BinaryFloatingPoint&DataType> {
    public static var sobel3x3H: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, 0, 1,
                                                 -2, 0, 2,
                                                 -1, 0, 1])
    }
    
    public static var sobel3x3V: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, -2, -1,
                                                 +0, +0, +0,
                                                 +1, +2, +1])
    }
    
    public static var prewitt3x3H: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, 0, 1,
                                                 -1, 0, 1,
                                                 -1, 0, 1])
    }
    
    public static var prewitt3x3V: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, -1, -1,
                                                 +0, +0, +0,
                                                 +1, +1, +1])
    }
    
    public static var laplacian3x3: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [+0, +1, +0,
                                                 +1, -4, +1,
                                                 +0, +1, +0])
    }
    
    public static var gaussian3x3: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [0.0625,  0.125, 0.0625,
                                                 0.125,   0.25,  0.125,
                                                 0.0625,  0.125, 0.0625])
    }
}

func im2col<T>(image: Image<Intensity, T>, width: Int, height: Int) -> [T] {
    
    let dx = -width/2
    let dy = -height/2
    
    var ret: [T] = []
    ret.reserveCapacity(width*height)
    
    for h in 0..<height {
        for w in 0..<width {
            for y in 0..<image.height {
                let yy = min(max(y + dy + h, 0), image.height-1)
                for x in 0..<image.width {
                    let xx = min(max(x + dx + w, 0), image.width-1)
                    ret.append(image[xx, yy])
                }
            }
        }
    }
    return ret
}

extension Image where T: FloatingPoint {
    func _convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        var ret = Image<P, T>(width: width, height: height)
        
        for c in 0..<P.channels {
            let matrix = im2col(image: self[channel: c], width: filter.width, height: filter.height)
            let result = _matmul(lhs: filter.data, rhs: matrix, m: 1, n: width*height, p: filter.width*filter.height)
            ret[channel: c] = Image<Intensity, T>(width: width, height: height, data: result)
        }
        
        return ret
    }
}

extension Image where P == Intensity, T: FloatingPoint {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}

extension Image where P == RGB, T: FloatingPoint {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}
