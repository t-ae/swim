
extension DataContainer where DT: Numeric {
    static func addAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.count == rhs.count, "Size mismatch.")
        lhs.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee += rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    static func subtractAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.count == rhs.count, "Size mismatch.")
        lhs.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee -= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    static func multiplyAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.count == rhs.count, "Size mismatch.")
        lhs.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee *= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Self, rhs: Self) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Self, rhs: Self) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Self, rhs: Self) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryInteger {
    static func divideAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.count == rhs.count, "Size mismatch.")
        lhs.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    public static func /(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Self, rhs: Self) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryFloatingPoint {
    static func divideAssign(lhs: inout Self, rhs: Self) {
        precondition(lhs.count == rhs.count, "Size mismatch.")
        lhs.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    public static func /(lhs: Self, rhs: Self) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Self, rhs: Self) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    extension DataContainer where DT == Float {
        static func addAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vadd(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
        
        static func subtractAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vsub(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
        
        static func multiplyAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vmul(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
        
        static func divideAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vdiv(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
    }
    
    extension DataContainer where DT == Double {
        static func addAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vaddD(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
        
        static func subtractAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vsubD(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
        
        static func multiplyAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vmulD(lp, 1, rp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
        
        static func divideAssign(lhs: inout Self, rhs: Self) {
            precondition(lhs.count == rhs.count, "Size mismatch.")
            lhs.withUnsafeMutableBufferPointer {
                let lp = $0.baseAddress!
                rhs.withUnsafeBufferPointer {
                    let rp = $0.baseAddress!
                    vDSP_vdivD(rp, 1, lp, 1, lp, 1, vDSP_Length($0.count))
                }
            }
        }
    }
#endif
