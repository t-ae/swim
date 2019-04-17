extension DataContainer where DT: SignedNumeric {
    @inlinable
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
    
    @inlinable
    public static prefix func -(arg: Self) -> Self {
        return negate(arg: arg)
    }
    
    @inlinable
    public static prefix func +(arg: Self) -> Self {
        return arg
    }
}

// MARK: - Accelerate
#if canImport(Accelerate)

import Accelerate

extension DataContainer where DT == Float {
    @inlinable
    static func negate(arg: Self) -> Self {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vneg($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
    
    @inlinable
    public static prefix func -(arg: Self) -> Self {
        return negate(arg: arg)
    }
}

extension DataContainer where DT == Double {
    @inlinable
    static func negate(arg: Self) -> Self {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vnegD($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
    
    @inlinable
    public static prefix func -(arg: Self) -> Self {
        return negate(arg: arg)
    }
}

#endif
