
// protocol
public protocol CompoundArithmetics {
    static func +=(lhs: inout Self, rhs: Self)
    static func -=(lhs: inout Self, rhs: Self)
    static func *=(lhs: inout Self, rhs: Self)
    static func /=(lhs: inout Self, rhs: Self)
}

extension UInt8: CompoundArithmetics {}
extension Int: CompoundArithmetics {}
extension Float: CompoundArithmetics {}
extension Double: CompoundArithmetics {}

extension Image where T: CompoundArithmetics {
    
    static func add(lhs: inout Image<P, T>, rhs: T) {
        lhs.unsafeChannelwiseConvert {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    static func subtract(lhs: inout Image<P, T>, rhs: T) {
        lhs.unsafeChannelwiseConvert {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
    
    static func multiply(lhs: inout Image<P, T>, rhs: T) {
        lhs.unsafeChannelwiseConvert {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee *= rhs
                p += 1
            }
        }
    }
    
    static func divide(lhs: inout Image<P, T>, rhs: T) {
        lhs.unsafeChannelwiseConvert {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}


// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    extension Image where T == Float {
        static func add(lhs: inout Image<P, T>, rhs: T) {
            var rhs = rhs
            lhs.unsafeChannelwiseConvert {
                vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtract(lhs: inout Image<P, T>, rhs: T) {
            add(lhs: &lhs, rhs: -rhs)
        }
        
        static func multiply(lhs: inout Image<P, T>, rhs: T) {
            var rhs = rhs
            lhs.unsafeChannelwiseConvert {
                vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divide(lhs: inout Image<P, T>, rhs: T) {
            var rhs = rhs
            lhs.unsafeChannelwiseConvert {
                vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
    }
    
    extension Image where T == Double {
        static func add(lhs: inout Image<P, T>, rhs: T) {
            var rhs = rhs
            lhs.unsafeChannelwiseConvert {
                vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func subtract(lhs: inout Image<P, T>, rhs: T) {
            add(lhs: &lhs, rhs: -rhs)
        }
        
        static func multiply(lhs: inout Image<P, T>, rhs: T) {
            var rhs = rhs
            lhs.unsafeChannelwiseConvert {
                vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
        
        static func divide(lhs: inout Image<P, T>, rhs: T) {
            var rhs = rhs
            lhs.unsafeChannelwiseConvert {
                vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
            }
        }
    }

#endif
