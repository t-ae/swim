
// MARK: - Unary
extension DataContainer where DT: SignedNumeric {
    static func negate(arg: Self) -> Self {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = -p.pointee
                p += 1
            }
        }
        return ret
    }
    
    public static prefix func -(arg: Self) -> Self {
        return negate(arg: arg)
    }
}

// MARK: - Binary
extension DataContainer where DT: Numeric {
    
    static func addAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    static func subtractAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
    
    static func multiplyAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee *= rhs
                p += 1
            }
        }
    }
    
    public static func +(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Self, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Self, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Self, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryInteger {
    static func divideAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    public static func /(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Self, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryFloatingPoint {
    static func divideAssign(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    public static func /(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Self, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}


// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    extension DataContainer where DT == Float {
        
        static func negate(arg: Self) -> Self {
            var ret = arg
            ret.data.withUnsafeMutableBufferPointer {
                vDSP_vneg($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
            return ret
        }
        
        static func addAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtractAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            addAssign(lhs: &lhs, rhs: -rhs)
        }
        
        static func multiplyAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divideAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
    }
    
    extension DataContainer where DT == Double {
        
        static func negate(arg: Self) -> Self {
            var ret = arg
            ret.data.withUnsafeMutableBufferPointer {
                vDSP_vnegD($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
            return ret
        }
        
        static func addAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtractAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            addAssign(lhs: &lhs, rhs: -rhs)
        }
        
        static func multiplyAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divideAssign(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
    }

#endif
