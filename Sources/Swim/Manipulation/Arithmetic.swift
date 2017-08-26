
// protocol
public protocol CompoundArithmetics {
    static func +=(lhs: inout Self, rhs: Self)
    static func -=(lhs: inout Self, rhs: Self)
    static func *=(lhs: inout Self, rhs: Self)
    static func /=(lhs: inout Self, rhs: Self)
}

extension UInt8: CompoundArithmetics {}
extension Float: CompoundArithmetics {}
extension Double: CompoundArithmetics {}

public func +<P, T: CompoundArithmetics>(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
    var ret = lhs
    ret += rhs
    return ret
}

public func +=<P, T: CompoundArithmetics>(lhs: inout Image<P, T>, rhs: T) {
    lhs.data.withUnsafeMutableBufferPointer {
        var p = $0.baseAddress!
        for _ in 0..<$0.count {
            p.pointee += rhs
            p += 1
        }
    }
}

public func -<P, T: CompoundArithmetics>(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
    var ret = lhs
    ret -= rhs
    return ret
}

public func -=<P, T: CompoundArithmetics>(lhs: inout Image<P, T>, rhs: T) {
    lhs.data.withUnsafeMutableBufferPointer {
        var p = $0.baseAddress!
        for _ in 0..<$0.count {
            p.pointee -= rhs
            p += 1
        }
    }
}

public func *<P, T: CompoundArithmetics>(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
    var ret = lhs
    ret *= rhs
    return ret
}

public func *=<P, T: CompoundArithmetics>(lhs: inout Image<P, T>, rhs: T) {
    lhs.data.withUnsafeMutableBufferPointer {
        var p = $0.baseAddress!
        for _ in 0..<$0.count {
            p.pointee *= rhs
            p += 1
        }
    }
}

public func /<P, T: CompoundArithmetics>(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
    var ret = lhs
    ret /= rhs
    return ret
}

public func /=<P, T: CompoundArithmetics>(lhs: inout Image<P, T>, rhs: T) {
    lhs.data.withUnsafeMutableBufferPointer {
        var p = $0.baseAddress!
        for _ in 0..<$0.count {
            p.pointee /= rhs
            p += 1
        }
    }
}

// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    // MARK: Float
    public func +<P>(lhs: Image<P, Float>, rhs: Float) -> Image<P, Float> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public func +=<P>(lhs: inout Image<P, Float>, rhs: Float) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    public func -<P>(lhs: Image<P, Float>, rhs: Float) -> Image<P, Float> {
        var ret = lhs
        ret += -rhs
        return ret
    }
    
    public func -=<P>(lhs: inout Image<P, Float>, rhs: Float) {
        lhs += -rhs
    }
    
    public func *<P>(lhs: Image<P, Float>, rhs: Float) -> Image<P, Float> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public func *=<P>(lhs: inout Image<P, Float>, rhs: Float) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    public func /<P>(lhs: Image<P, Float>, rhs: Float) -> Image<P, Float> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public func /=<P>(lhs: inout Image<P, Float>, rhs: Float) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    // MARK: Double
    public func +<P>(lhs: Image<P, Double>, rhs: Double) -> Image<P, Double> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public func +=<P>(lhs: inout Image<P, Double>, rhs: Double) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    public func -<P>(lhs: Image<P, Double>, rhs: Double) -> Image<P, Double> {
        var ret = lhs
        ret += -rhs
        return ret
    }
    
    public func -=<P>(lhs: inout Image<P, Double>, rhs: Double) {
        lhs += -rhs
    }
    
    public func *<P>(lhs: Image<P, Double>, rhs: Double) -> Image<P, Double> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public func *=<P>(lhs: inout Image<P, Double>, rhs: Double) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    public func /<P>(lhs: Image<P, Double>, rhs: Double) -> Image<P, Double> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public func /=<P>(lhs: inout Image<P, Double>, rhs: Double) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }

#endif
