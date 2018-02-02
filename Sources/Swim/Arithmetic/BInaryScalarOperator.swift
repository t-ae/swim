
extension DataContainer where DT: Numeric {
    static func addAssign(lhs: inout Self, rhs: DT) {
        lhs.withUnsafeMutableBufferPointerToData {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    static func subtractAssign(lhs: inout Self, rhs: DT) {
        lhs.withUnsafeMutableBufferPointerToData {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
    
    static func subtract(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret.withUnsafeMutableBufferPointerToData {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs - p.pointee
                p += 1
            }
        }
        return ret
    }
    
    static func multiplyAssign(lhs: inout Self, rhs: DT) {
        lhs.withUnsafeMutableBufferPointerToData {
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
    
    public static func +(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret += lhs
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
    
    public static func -(lhs: DT, rhs: Self) -> Self {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Self, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Self, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryInteger {
    static func divideAssign(lhs: inout Self, rhs: DT) {
        lhs.withUnsafeMutableBufferPointerToData {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    static func divide(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret.withUnsafeMutableBufferPointerToData {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs / p.pointee
                p += 1
            }
        }
        return ret
    }
    
    public static func /(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /(lhs: DT, rhs: Self) -> Self {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Self, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: FloatingPoint {
    static func divideAssign(lhs: inout Self, rhs: DT) {
        lhs.withUnsafeMutableBufferPointerToData {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    static func divide(lhs: DT, rhs: Self) -> Self {
        var ret = rhs
        ret.withUnsafeMutableBufferPointerToData {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs / p.pointee
                p += 1
            }
        }
        return ret
    }
    
    public static func /(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /(lhs: DT, rhs: Self) -> Self {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Self, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    extension DataContainer where DT == Float {

        static func addAssign(lhs: inout Self, rhs: DT) {
            var rhs = rhs
            lhs.withUnsafeMutableBufferPointerToData {
                vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtractAssign(lhs: inout Self, rhs: DT) {
            addAssign(lhs: &lhs, rhs: -rhs)
        }
        
        static func subtract(lhs: DT, rhs: Self) -> Self {
            var ret = negate(arg: rhs)
            addAssign(lhs: &ret, rhs: lhs)
            return ret
        }
        
        static func multiplyAssign(lhs: inout Self, rhs: DT) {
            var rhs = rhs
            lhs.withUnsafeMutableBufferPointerToData {
                vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divideAssign(lhs: inout Self, rhs: DT) {
            var rhs = rhs
            lhs.withUnsafeMutableBufferPointerToData {
                vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divide(lhs: DT, rhs: Self) -> Self {
            var ret = rhs
            var lhs = lhs
            ret.withUnsafeMutableBufferPointerToData {
                vDSP_svdiv(&lhs, $0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
            return ret
        }
    }
    
    extension DataContainer where DT == Double {
        
        static func addAssign(lhs: inout Self, rhs: DT) {
            var rhs = rhs
            lhs.withUnsafeMutableBufferPointerToData {
                vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtractAssign(lhs: inout Self, rhs: DT) {
            addAssign(lhs: &lhs, rhs: -rhs)
        }
        
        static func subtract(lhs: DT, rhs: Self) -> Self {
            var ret = negate(arg: rhs)
            addAssign(lhs: &ret, rhs: lhs)
            return ret
        }
        
        static func multiplyAssign(lhs: inout Self, rhs: DT) {
            var rhs = rhs
            lhs.withUnsafeMutableBufferPointerToData {
                vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divideAssign(lhs: inout Self, rhs: DT) {
            var rhs = rhs
            lhs.withUnsafeMutableBufferPointerToData {
                vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divide(lhs: DT, rhs: Self) -> Self {
            var ret = rhs
            var lhs = lhs
            ret.withUnsafeMutableBufferPointerToData {
                vDSP_svdivD(&lhs, $0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
            return ret
        }
    }
    
#endif
