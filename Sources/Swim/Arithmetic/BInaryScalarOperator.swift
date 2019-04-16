extension DataContainer where DT: Numeric {
    @usableFromInline
    static func addAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    @usableFromInline
    static func subtractAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
    
    @usableFromInline
    static func subtract(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs - p.pointee
                p += 1
            }
        }
        return ret
    }
    
    @usableFromInline
    static func multiplyAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee *= rhs
                p += 1
            }
        }
    }
    
    @inlinable
    public static func +(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func +(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    @inlinable
    public static func +=(lhs: inout Self, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: DT, rhs: Self) -> Self {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    @inlinable
    public static func *(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    @inlinable
    public static func *=(lhs: inout Self, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryInteger {
    @usableFromInline
    static func divideAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    @usableFromInline
    static func divide(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs / p.pointee
                p += 1
            }
        }
        return ret
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: DT, rhs: Self) -> Self {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: FloatingPoint {
    @usableFromInline
    static func divideAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    @inlinable
    static func divide(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs / p.pointee
                p += 1
            }
        }
        return ret
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: DT, rhs: Self) -> Self {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

// MARK: - Accelerate
#if canImport(Accelerate)

import Accelerate

extension DataContainer where DT == Float {
    @usableFromInline
    static func addAssign(lhs: inout Self, rhs: DT) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @usableFromInline
    static func subtractAssign(lhs: inout Self, rhs: DT) {
        addAssign(lhs: &lhs, rhs: -rhs)
    }
    
    @usableFromInline
    static func subtract(lhs: DT, rhs: Self) -> Self {
        var ret = negate(arg: rhs)
        addAssign(lhs: &ret, rhs: lhs)
        return ret
    }
    
    @usableFromInline
    static func multiplyAssign(lhs: inout Self, rhs: DT) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @usableFromInline
    static func divideAssign(lhs: inout Self, rhs: DT) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @usableFromInline
    static func divide(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        var lhs = lhs
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_svdiv(&lhs, $0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
}

extension DataContainer where DT == Double {
    @usableFromInline
    static func addAssign(lhs: inout Self, rhs: DT) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @usableFromInline
    static func subtractAssign(lhs: inout Self, rhs: DT) {
        addAssign(lhs: &lhs, rhs: -rhs)
    }
    
    @usableFromInline
    static func subtract(lhs: DT, rhs: Self) -> Self {
        var ret = negate(arg: rhs)
        addAssign(lhs: &ret, rhs: lhs)
        return ret
    }
    
    @usableFromInline
    static func multiplyAssign(lhs: inout Self, rhs: DT) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @usableFromInline
    static func divideAssign(lhs: inout Self, rhs: DT) {
        var rhs = rhs
        lhs.data.withUnsafeMutableBufferPointer {
            vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @usableFromInline
    static func divide(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        var lhs = lhs
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_svdivD(&lhs, $0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
}

#endif
