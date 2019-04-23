extension Image where T: AdditiveArithmetic {
    @inlinable
    static func addAssign(lhs: inout Image, rhs: Image) {
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
    static func subtractAssign(lhs: inout Image, rhs: Image) {
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
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where T: Numeric {
    @inlinable
    static func multiplyAssign(lhs: inout Image, rhs: Image) {
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
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    static func divideAssign(lhs: inout Image<P, T>, rhs: Image<P, T>) {
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
    public static func /=(lhs: inout Image<P, T>, rhs: Image<P, T>) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    static func divideAssign(lhs: inout Image, rhs: Image) {
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
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

#if canImport(Accelerate)

import Accelerate

extension Image where T == Float {
    @inlinable
    static func addAssign(lhs: inout Image, rhs: Image) {
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
    static func subtractAssign(lhs: inout Image, rhs: Image) {
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
    static func multiplyAssign(lhs: inout Image, rhs: Image) {
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
    static func divideAssign(lhs: inout Image, rhs: Image) {
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
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where T == Double {
    @inlinable
    static func addAssign(lhs: inout Image, rhs: Image) {
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
    static func subtractAssign(lhs: inout Image, rhs: Image) {
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
    static func multiplyAssign(lhs: inout Image, rhs: Image) {
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
    static func divideAssign(lhs: inout Image, rhs: Image) {
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
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

#endif
