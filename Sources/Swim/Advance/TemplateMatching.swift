
import Foundation

public func calculateSSD<T: DataType&BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                         _ b: Image<Intensity, T>) -> T {
    precondition(a.width == b.width)
    precondition(a.height == a.height)
    
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

public func calculateSAD<T: DataType&BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                         _ b: Image<Intensity, T>) -> T {
    precondition(a.width == b.width)
    precondition(a.height == a.height)
    
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

public func calculateNCC<T: DataType&BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                         _ b: Image<Intensity, T>) -> T {
    precondition(a.width == b.width)
    precondition(a.height == a.height)
    
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

public func calculateZNCC<T: DataType&BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                          _ b: Image<Intensity, T>) -> T {
    precondition(a.width == b.width)
    precondition(a.height == a.height)
    
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
    let up = (c*sumCross - sum2a*sum2b)
    let da = (c*sum2a - suma*suma)
    let db = (c*sum2b - sumb*sumb)
    return up / sqrt(da*db)
}
