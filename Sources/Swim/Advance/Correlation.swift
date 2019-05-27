import Foundation

public enum Correlation<T: DataType> {
    
}

extension Correlation where T: Strideable {
    /// Compute sum of square difference.
    ///
    /// - Parameters:
    ///   - mask: If given, `false` coords are ignored.
    /// - Precondition: a.size == b.size (== mask.size)
    @inlinable
    public static func ssd(_ a: Image<Gray, T>, _ b: Image<Gray, T>, mask: Image<Gray, Bool>? = nil) -> T.Stride {
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
    public static func sad(_ a: Image<Gray, T>, _ b: Image<Gray, T>, mask: Image<Gray, Bool>? = nil) -> T.Stride {
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

extension Correlation where T: BinaryFloatingPoint {
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
        let denominator: T = c*sumCross - sumasumb
        
        let numeratorA: T = c*sum2a - suma2
        let numeratorB: T = c*sum2b - sumb2

        let numerator = sqrt(numeratorA*numeratorB) + epsilon
        
        return clamp(denominator / numerator, min: -1, max: 1)
    }
}


