// MARK: - Filter
public enum Filter<T: Numeric&DataType> {
    public static var sobel3x3H: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, 0, 1,
                                                 -2, 0, 2,
                                                 -1, 0, 1])
    }
    
    public static var sobel3x3V: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, -2, -1,
                                                 0, 0, 0,
                                                 1, 2, 1])
    }
    
    public static var prewitt3x3H: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, 0, 1,
                                                 -1, 0, 1,
                                                 -1, 0, 1])
    }
    
    public static var prewitt3x3V: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-1, -1, -1,
                                                 0, 0, 0,
                                                 1, 1, 1])
    }
    
    public static var laplacian3x3: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [0, 1, 0,
                                                 1, -4, 1,
                                                 0, 1, 0])
    }
    
    public static var emboss3x3: Image<Intensity, T> {
        return Image(width: 3, height: 3, data: [-2, -1, 0,
                                                 -1,  1, 1,
                                                  0,  1, 2])
    }
}

extension Filter where T: FloatingPoint {
    public static var gaussian3x3: Image<Intensity, T> {
        let data: [T] = [1, 2, 1,
                         2, 4, 2,
                         1, 2, 1]
        return Image(width: 3, height: 3, data: data.map { $0 / 16 })
    }
    
    public static var gaussian5x5: Image<Intensity, T> {
        let data: [T] = [1,  4,  6,  4, 1,
                         4, 16, 24, 16, 4,
                         6, 24, 36, 24, 6,
                         4, 16, 24, 16, 4,
                         1,  4,  6,  4, 1]
        return Image(width: 5, height: 5, data: data.map { $0 / 256 })
    }
    
    public static var mean3x3: Image<Intensity, T> {
        return Image(width: 3, height: 3, value: 1/9)
    }
    
    public static var mean5x5: Image<Intensity, T> {
        return Image(width: 5, height: 5, value: 1/25)
    }
}

// MARK: - convoluted
extension Image where T: Numeric {
    @inlinable
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        var newImage = Image<P, T>(width: width, height: height)
        
        for c in 0..<P.channels {
            let (m, n, matrix) = self[channel: c].im2col(patchWidth: filter.width, patchHeight: filter.height)
            let result = matmul(lhs: filter.data, rhs: matrix, m: 1, n: n, p: m)
            newImage[channel: c] = Image<Intensity, T>(width: width, height: height, data: result)
        }
        
        return newImage
    }
}
