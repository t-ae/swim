import Foundation

// MARK: - Filter
public enum Filter<T: SignedNumeric&DataType> {
    public static var sobel3x3H: Image<Gray, T> {
        return Image(width: 3, height: 3, data: [-1, 0, 1,
                                                 -2, 0, 2,
                                                 -1, 0, 1])
    }
    
    public static var sobel3x3V: Image<Gray, T> {
        return Image(width: 3, height: 3, data: [-1, -2, -1,
                                                 0, 0, 0,
                                                 1, 2, 1])
    }
    
    public static var prewitt3x3H: Image<Gray, T> {
        return Image(width: 3, height: 3, data: [-1, 0, 1,
                                                 -1, 0, 1,
                                                 -1, 0, 1])
    }
    
    public static var prewitt3x3V: Image<Gray, T> {
        return Image(width: 3, height: 3, data: [-1, -1, -1,
                                                 0, 0, 0,
                                                 1, 1, 1])
    }
    
    public static var laplacian3x3: Image<Gray, T> {
        return Image(width: 3, height: 3, data: [0, 1, 0,
                                                 1, -4, 1,
                                                 0, 1, 0])
    }
    
    public static var emboss3x3: Image<Gray, T> {
        return Image(width: 3, height: 3, data: [-2, -1, 0,
                                                 -1,  1, 1,
                                                  0,  1, 2])
    }
}

extension Filter where T: FloatingPoint {
    public static var gaussian3x3: Image<Gray, T> {
        let data: [T] = [1, 2, 1,
                         2, 4, 2,
                         1, 2, 1]
        return Image(width: 3, height: 3, data: data.map { $0 / 16 })
    }
    
    public static var gaussian5x5: Image<Gray, T> {
        let data: [T] = [1,  4,  6,  4, 1,
                         4, 16, 24, 16, 4,
                         6, 24, 36, 24, 6,
                         4, 16, 24, 16, 4,
                         1,  4,  6,  4, 1]
        return Image(width: 5, height: 5, data: data.map { $0 / 256 })
    }
    
    public static func mean(size: Int) -> Image<Gray, T> {
        return Image(width: size, height: size, value: 1 / T(size*size))
    }
}

extension Filter where T == Double {
    /// 2D Gaussian.
    ///
    /// - Parameters:
    ///   - size: Width/height of imege.
    ///   - sigma: Standard deviation of Gaussian.
    ///   - scaleTo1: If true, output pixel values are scaled so that these sum is 1.
    @inlinable
    public static func gaussian(size: Int, sigma: T, scaleTo1: Bool = false) -> Image<Gray, T> {
        let sigma2 = sigma * sigma
        let c = 1 / (2 * T.pi * sigma2).squareRoot()
        
        let gauss1D = Matrix<T>(rows: 1, cols: size, data: (0..<size).map {
            let d = T($0) - T(size-1)/2
            return c * exp(-d*d / (2*sigma2))
        })
        
        let gauss2D = gauss1D.transposed() * gauss1D
        
        var image = Image<Gray, T>(width: size, height: size, data: gauss2D.data)
        
        if scaleTo1 {
            image /= image.data.reduce(0, +)
        }
        
        return image
    }
}

// MARK: - convoluted
extension Image where T: Numeric {
    /// Apply convolution with specified linear `filter`.
    ///
    /// `filter` will be applied to each channel separately.
    @inlinable
    public func convoluted(_ filter: Image<Gray, T>) -> Image<P, T> {
        let padLeft = (filter.width-1)/2
        let padTop = (filter.height-1)/2
        
        // TODO: first zero fill?
        
        return .createWithUnsafePixelRef(width: width, height: height) { ref in
            ref.pointer.initialize(repeating: 0)
            
            for py in 0..<filter.height {
                let yy = clamp(ref.y+py-padTop, min: 0, max: height-1)
                for px in 0..<filter.width {
                    let xx = clamp(ref.x+px-padLeft, min: 0, max: width-1)

                    ref.addColor(x: xx, y: yy, in: self, with: filter[px, py, .gray])
                }
            }
        }
    }
}
