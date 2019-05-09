// MARK: - Filter
public enum Filter<T: SignedNumeric&DataType> {
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
    /// Convolve image with specified `filter`.
    /// `filter` will be applied to each channel respectively.
    @inlinable
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        var newImage = Image<P, T>(width: width, height: height, value: 0)
        
        let padLeft = (filter.width-1)/2
        let padTop = (filter.height-1)/2
        
        for py in 0..<filter.height {
            for y in 0..<height {
                let yy = clamp(y+py-padTop, min: 0, max: height-1)
                
                for px in 0..<filter.width {
                    for x in 0..<width {
                        let xx = clamp(x+px-padLeft, min: 0, max: width-1)
                        
                        for c in 0..<P.channels {
                            newImage[x, y, c] += self[xx, yy, c] * filter[px, py, 0]
                        }
                    }
                }
            }
        }
        
        return newImage
    }
}
