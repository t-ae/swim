extension Image where T: SignedNumeric {
    @inlinable
    static func negate(arg: Image) -> Image {
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
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
    
    @inlinable
    public static prefix func +(arg: Image) -> Image {
        return arg
    }
}

// MARK: - Accelerate
#if canImport(Accelerate)

import Accelerate

extension Image where T == Float {
    @inlinable
    static func negate(arg: Image) -> Image {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vneg($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
    
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where T == Double {
    @inlinable
    static func negate(arg: Image) -> Image {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vnegD($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
    
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

#endif
