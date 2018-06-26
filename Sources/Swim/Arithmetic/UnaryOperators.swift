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
    
    public static prefix func +(arg: Self) -> Self {
        return arg
    }
}

// MARK: - Accelerate
#if canImport(Accelerate)

import Accelerate

extension DataContainer where DT == Float {
    
    static func negate(arg: Self) -> Self {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vneg($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
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
}

#endif
