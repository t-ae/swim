
import Foundation

public enum Correlation<T: BinaryFloatingPoint&DataType> {
    static func _ssd(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        
        var sum: T = 0
        a.data.withUnsafeBufferPointer {
            var ap = $0.baseAddress!
            b.data.withUnsafeBufferPointer {
                var bp = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    sum += (ap.pointee - bp.pointee) * (ap.pointee - bp.pointee)
                    ap += 1
                    bp += 1
                }
            }
        }
        return sum
    }
    
    public static func ssd(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _ssd(a, b)
    }
    
    static func _sad(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        
        var sum: T = 0
        a.data.withUnsafeBufferPointer {
            var ap = $0.baseAddress!
            b.data.withUnsafeBufferPointer {
                var bp = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    sum += abs(ap.pointee - bp.pointee)
                    ap += 1
                    bp += 1
                }
            }
        }
        return sum
    }
    
    public static func sad(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _sad(a, b)
    }
    
    static func _ncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        
        var sum2a: T = 0
        var sum2b: T = 0
        var sumCross: T = 0
        
        a.data.withUnsafeBufferPointer {
            var ap = $0.baseAddress!
            b.data.withUnsafeBufferPointer {
                var bp = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    sum2a += ap.pointee*ap.pointee
                    sum2b += bp.pointee*bp.pointee
                    sumCross += ap.pointee*bp.pointee
                    ap += 1
                    bp += 1
                }
            }
        }
        return sumCross / sqrt(sum2a * sum2b)
    }
    
    public static func ncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _ncc(a, b)
    }
    
    static func _zncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        precondition(a.size == b.size, "Images must have same size.")
        
        var suma: T = 0
        var sumb: T = 0
        var sum2a: T = 0
        var sum2b: T = 0
        var sumCross: T = 0
        
        a.data.withUnsafeBufferPointer {
            var ap = $0.baseAddress!
            b.data.withUnsafeBufferPointer {
                var bp = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    suma += ap.pointee
                    sumb += bp.pointee
                    sum2a += ap.pointee*ap.pointee
                    sum2b += bp.pointee*bp.pointee
                    sumCross += ap.pointee*bp.pointee
                    ap += 1
                    bp += 1
                }
            }
        }
        
        let c = T(a.width * a.height)
        let up = (c*sumCross - suma*sumb)
        let da = (c*sum2a - suma*suma)
        let db = (c*sum2b - sumb*sumb)
        return up / sqrt(da*db)
    }
    
    public static func zncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _zncc(a, b)
    }
}


