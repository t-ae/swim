import Foundation

public enum Correlation<T: DataType> {
    
}

extension Correlation where T: Strideable {
    /// Compute sum of square difference.
    @inlinable
    public static func ssd(_ a: Image<Gray, T>, _ b: Image<Gray, T>) -> T.Stride {
        precondition(a.size == b.size, "Images must have same size.")
        
        var sum: T.Stride = 0
        for i in 0..<a.data.count {
            let distance = a.data[i].distance(to: b.data[i])
            sum += distance*distance
        }
        return sum
    }
    
    /// Compute sum of square difference.
    @inlinable
    public static func sad(_ a: Image<Gray, T>, _ b: Image<Gray, T>) -> T.Stride {
        precondition(a.size == b.size, "Images must have same size.")
        
        var sum: T.Stride = 0
        for i in 0..<a.data.count {
            sum += abs(a.data[i].distance(to: b.data[i]))
        }
        return sum
    }
}

extension Correlation where T: FloatingPoint {
    /// Compute normalized cross correlation.
    /// - Precondition: Each of `a` and `b` have at least one non-zero value.
    @inlinable
    public static func ncc(_ a: Image<Gray, T>, _ b: Image<Gray, T>) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        
        var sum2a: T = 0
        var sum2b: T = 0
        var sumCross: T = 0
        
        for i in 0..<a.data.count {
            sum2a += a.data[i]*a.data[i]
            sum2b += b.data[i]*b.data[i]
            sumCross += a.data[i]*b.data[i]
        }
        
        precondition(sum2a > 0, "`a` is all zero.")
        precondition(sum2b > 0, "`b` is all zero.")
        
        return sumCross / sqrt(sum2a * sum2b)
    }
    
    /// Compute zero means normalized cross correlation.
    /// - Precondition: Each of `a` and `b` can't have same value in all pixels.
    @inlinable
    public static func zncc(_ a: Image<Gray, T>, _ b: Image<Gray, T>) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        
        var suma: T = 0
        var sumb: T = 0
        var sum2a: T = 0
        var sum2b: T = 0
        var sumCross: T = 0
        
        for i in 0..<a.data.count {
            suma += a.data[i]
            sumb += b.data[i]
            sum2a += a.data[i]*a.data[i]
            sum2b += b.data[i]*b.data[i]
            sumCross += a.data[i]*b.data[i]
        }
        
        let c: T = T(a.width * a.height)
        let sumasumb = suma*sumb
        let suma2 = suma*suma
        let sumb2 = sumb*sumb
        let up: T = c*sumCross - sumasumb
        
        let da: T = c*sum2a - suma2
        let db: T = c*sum2b - sumb2
        
        precondition(da > 0, "All pixels in `a` have same value.")
        precondition(db > 0, "All pixels in `b` have same value.")
        
        return clamp(up / sqrt(da*db), min: -1, max: 1)
    }
}


