
import Foundation

func _calculateSSD<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                           _ b: Image<Intensity, T>) -> T {
    precondition(a.size == b.size, "Images must have same size.")
    
    var sum: T = 0
    a._data.withUnsafeBufferPointer {
        var ap = $0.baseAddress!
        b._data.withUnsafeBufferPointer {
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

public func calculateSSD<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                                 _ b: Image<Intensity, T>) -> T {
    return _calculateSSD(a, b)
}

func _calculateSAD<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                           _ b: Image<Intensity, T>) -> T {
    precondition(a.size == b.size, "Images must have same size.")
    
    var sum: T = 0
    a._data.withUnsafeBufferPointer {
        var ap = $0.baseAddress!
        b._data.withUnsafeBufferPointer {
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

public func calculateSAD<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                                 _ b: Image<Intensity, T>) -> T {
    return _calculateSAD(a, b)
}

func _calculateNCC<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                           _ b: Image<Intensity, T>) -> T {
    precondition(a.size == b.size, "Images must have same size.")
    
    var sum2a: T = 0
    var sum2b: T = 0
    var sumCross: T = 0
    
    a._data.withUnsafeBufferPointer {
        var ap = $0.baseAddress!
        b._data.withUnsafeBufferPointer {
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

public func calculateNCC<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                                 _ b: Image<Intensity, T>) -> T {
    return _calculateNCC(a, b)
}

func _calculateZNCC<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                            _ b: Image<Intensity, T>) -> T {
    precondition(a.size == b.size, "Images must have same size.")
    
    var suma: T = 0
    var sumb: T = 0
    var sum2a: T = 0
    var sum2b: T = 0
    var sumCross: T = 0
    
    a._data.withUnsafeBufferPointer {
        var ap = $0.baseAddress!
        b._data.withUnsafeBufferPointer {
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

public func calculateZNCC<T: BinaryFloatingPoint>(_ a: Image<Intensity, T>,
                                                  _ b: Image<Intensity, T>) -> T {
    return _calculateZNCC(a, b)
}
