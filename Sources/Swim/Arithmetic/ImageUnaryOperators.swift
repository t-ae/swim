extension Image where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee.negate()
                p += 1
            }
        }
        return ret
    }
    
    @inlinable
    public static prefix func +(arg: Image) -> Image {
        return arg
    }
}

// MARK: - Accelerate
#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

extension Image where T == Float {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vneg($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
}

extension Image where T == Double {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vnegD($0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
}

#endif
