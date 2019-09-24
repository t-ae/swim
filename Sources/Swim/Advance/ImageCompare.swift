import Foundation

public enum ImageCompare<T: DataType> {
    
}

extension ImageCompare where T: Strideable {
    /// Compute sum of square difference.
    ///
    /// - Parameters:
    ///   - mask: If given, `false` coords are ignored.
    /// - Precondition: a.size == b.size (== mask.size)
    @inlinable
    public static func ssd(_ a: Image<Gray, T>,
                           _ b: Image<Gray, T>,
                           mask: Image<Gray, Bool>? = nil) -> T.Stride {
        precondition(a.size == b.size, "Images must have same size.")
        precondition(a.size == mask?.size ?? a.size, "Mask must have same size as images.")
        
        var sum: T.Stride = 0
        for i in 0..<a.data.count {
            guard mask?.data[i] ?? true else {
                continue
            }
            let distance = a.data[i].distance(to: b.data[i])
            sum += distance*distance
        }
        return sum
    }
    
    /// Compute sum of square difference.
    ///
    /// - Parameters:
    ///   - mask: If given, `false` coords are ignored.
    /// - Precondition: a.size == b.size (== mask.size)
    @inlinable
    public static func sad(_ a: Image<Gray, T>,
                           _ b: Image<Gray, T>,
                           mask: Image<Gray, Bool>? = nil) -> T.Stride {
        precondition(a.size == b.size, "Images must have same size.")
        precondition(a.size == mask?.size ?? a.size, "Mask must have same size as images.")
        
        var sum: T.Stride = 0
        for i in 0..<a.data.count {
            guard mask?.data[i] ?? true else {
                continue
            }
            sum += abs(a.data[i].distance(to: b.data[i]))
        }
        return sum
    }
}

extension ImageCompare where T: BinaryFloatingPoint {
    /// Compute normalized cross correlation.
    ///
    /// - Parameters:
    ///   - mask: If given, `false` coords are ignored.
    ///   - epsilon: Small value for avoiding zero division.
    /// - Note: If values of `a` (or `b`) is all zero, this method always returns 0.
    /// - Precondition: a.size == b.size (== mask.size)
    @inlinable
    public static func ncc(_ a: Image<Gray, T>,
                           _ b: Image<Gray, T>,
                           mask: Image<Gray, Bool>? = nil,
                           epsilon: T = 1e-8) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        precondition(a.size == mask?.size ?? a.size, "Mask must have same size as images.")
        
        var sum2a: T = 0
        var sum2b: T = 0
        var sumCross: T = 0
        
        for i in 0..<a.data.count {
            guard mask?.data[i] ?? true else {
                continue
            }
            sum2a += a.data[i]*a.data[i]
            sum2b += b.data[i]*b.data[i]
            sumCross += a.data[i]*b.data[i]
        }
        
        let numerator = sqrt(sum2a * sum2b) + epsilon
        
        return sumCross / numerator
    }
    
    /// Compute zero means normalized cross correlation.
    ///
    /// - Parameters:
    ///   - mask: If given, `false` coords are ignored.
    ///   - epsilon: Small value for avoiding zero division.
    /// - Note: If values of `a` (or `b`) is all same, this method always returns 0.
    /// - Precondition: a.size == b.size (== mask.size)
    @inlinable
    public static func zncc(_ a: Image<Gray, T>,
                            _ b: Image<Gray, T>,
                            mask: Image<Gray, Bool>? = nil,
                            epsilon: T = 1e-8) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        precondition(a.size == mask?.size ?? a.size, "Mask must have same size as images.")
        
        var suma: T = 0
        var sumb: T = 0
        var sum2a: T = 0
        var sum2b: T = 0
        var sumCross: T = 0
        var count = 0
        
        for i in 0..<a.data.count {
            guard mask?.data[i] ?? true else {
                continue
            }
            suma += a.data[i]
            sumb += b.data[i]
            sum2a += a.data[i]*a.data[i]
            sum2b += b.data[i]*b.data[i]
            sumCross += a.data[i]*b.data[i]
            count += 1
        }
        
        let c = T(count)
        let sumasumb = suma*sumb
        let suma2 = suma*suma
        let sumb2 = sumb*sumb
        let numerator: T = c*sumCross - sumasumb
        
        let denominatorA: T = c*sum2a - suma2
        let denominatorB: T = c*sum2b - sumb2

        let denominator = sqrt(denominatorA*denominatorB) + epsilon
        
        return clamp(numerator / denominator, min: -1, max: 1)
    }
}


extension ImageCompare where T == Double {
    // TODO: Add Float version
    
    /// Compute peek signal/noise ratio.
    @inlinable
    public static func psnr(_ image1: Image<Gray, T>, _ image2: Image<Gray, T>) -> T {
        let ssd = ImageCompare.ssd(image1, image2)
        let mse = ssd / Double(image1.pixelCount)
        
        let psnr = 10 * log10(1 / mse)
        return psnr
    }
    
    /// Compute peek signal/noise ratio.
    @inlinable
    public static func psnr(_ image1: Image<RGB, T>, _ image2: Image<RGB, T>) -> T {
        return psnr(image1.toGray(), image2.toGray())
    }
    
    /// Compute mean structual similarity index.
    ///
    /// - Parameters:
    ///   - windowSize: Size of sliding window used in comparison.
    @inlinable
    public static func ssim(_ image1: Image<Gray, T>, _ image2: Image<Gray, T>,
                            windowSize: Int, k1: T = 0.01, k2: T = 0.03) -> T {
        precondition(image1.size == image2.size, "Images must have same size.")
        
        let c1 = k1*k1
        let c2 = k2*k2
        
        let winHalf = (windowSize-1) / 2
        
        let edgeMode = EdgeMode<Gray, T>.reflect
        func localSSIM(x: Int, y: Int) -> T {
            var suma: T = 0
            var sum2a: T = 0
            var sumb: T = 0
            var sum2b: T = 0
            var sumCross: T = 0
            for dy in 0..<windowSize {
                let y = edgeMode.clampValue(value: y + dy - winHalf, max: image1.height)!
                for dx in 0..<windowSize {
                    let x = edgeMode.clampValue(value: x + dx - winHalf, max: image1.width)!
                    
                    let a = image1[x, y, .gray]
                    let b = image2[x, y, .gray]
                    suma += a
                    sum2a += a*a
                    sumb += b
                    sum2b += b*b
                    sumCross += a*b
                }
            }
            
            let count = T(windowSize*windowSize)
            let meana = suma / count
            let meanb = sumb / count
            let vara = sum2a / count - meana*meana
            let varb = sum2b / count - meanb*meanb
            let cov = sumCross / count - meana*meanb
            
            let numerator = (2*meana*meanb + c1) * (2*cov + c2)
            let denominator = (meana*meana + meanb*meanb + c1) * (vara + varb + c2)
            
            return numerator / denominator
        }
        
        var sum: T = 0
        for y in 0..<image1.height {
            for x in 0..<image1.width {
                sum += localSSIM(x: x, y: y)
            }
        }
        
        return sum / T(image1.pixelCount)
    }
    
    /// Compute mean structual similarity index.
    ///
    /// - Parameters:
    ///   - windowSize: Size of sliding window used in comparison.
    @inlinable
    public static func ssim(_ image1: Image<RGB, T>, _ image2: Image<RGB, T>,
                            windowSize: Int, k1: T = 0.01, k2: T = 0.03) -> T {
        let rSSIM = ssim(image1[channel: .red], image2[channel: .red],
                           windowSize: windowSize, k1: k1, k2: k2)
        let gSSIM = ssim(image1[channel: .green], image2[channel: .green],
                           windowSize: windowSize, k1: k1, k2: k2)
        let bSSIM = ssim(image1[channel: .blue], image2[channel: .blue],
                           windowSize: windowSize, k1: k1, k2: k2)
        
        return (rSSIM + gSSIM + bSSIM) / 3
    }
}
