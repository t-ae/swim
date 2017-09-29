
// protocol

extension DataContainer where DT: Numeric {
    
    static func add(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    static func subtract(lhs: inout Self, rhs: DT) {
        lhs.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
    
    static func multiply(lhs: inout Self, rhs: DT) {
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
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Self, rhs: DT) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Self, rhs: DT) -> Self {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Self, rhs: DT) {
        multiply(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryInteger {
    static func divide(lhs: inout Self, rhs: DT) {
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
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where DT: BinaryFloatingPoint {
    static func divide(lhs: inout Self, rhs: DT) {
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
        divide(lhs: &lhs, rhs: rhs)
    }
}


// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    extension DataContainer where DT == Float {
        static func add(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtract(lhs: inout Image<PT, DT>, rhs: DT) {
            add(lhs: &lhs, rhs: -rhs)
        }
        
        static func multiply(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divide(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
    }
    
    extension DataContainer where DT == Double {
        static func add(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtract(lhs: inout Image<PT, DT>, rhs: DT) {
            add(lhs: &lhs, rhs: -rhs)
        }
        
        static func multiply(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divide(lhs: inout Image<PT, DT>, rhs: DT) {
            var rhs = rhs
            lhs._data.withUnsafeMutableBufferPointer {
                vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
    }

#endif
