extension DataContainer where DT: Numeric {
    @inlinable
    static func addAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee += rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    static func subtractAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee -= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    static func multiplyAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee *= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    public static func +(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func +=(lhs: inout Self, rhs: Self) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: Self) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    @inlinable
    public static func *=(lhs: inout Self, rhs: Self) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryInteger {
    @inlinable
    static func divideAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: Self) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: FloatingPoint {
    @inlinable
    static func divideAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: Self) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

// MARK: - Accelerate
#if canImport(Accelerate)

import Accelerate

extension DataContainer where DT == Float {
    @inlinable
    static func addAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vadd(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    static func subtractAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vsub(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    static func multiplyAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vmul(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    static func divideAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vdiv(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    public static func +(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func +=(lhs: inout Self, rhs: Self) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: Self) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    @inlinable
    public static func *=(lhs: inout Self, rhs: Self) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: Self) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT == Double {
    @inlinable
    static func addAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vaddD(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    static func subtractAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vsubD(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    static func multiplyAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vmulD(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    static func divideAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            let lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                let rp = $0.baseAddress!
                vDSP_vdivD(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    public static func +(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func +=(lhs: inout Self, rhs: Self) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: Self) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    @inlinable
    public static func *=(lhs: inout Self, rhs: Self) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: Self) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

#endif
