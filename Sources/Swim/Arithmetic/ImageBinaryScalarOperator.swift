// MARK: - Image
extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs - p.pointee
                p += 1
            }
        }
        return ret
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs / p.pointee
                p += 1
            }
        }
        return ret
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = lhs / p.pointee
                p += 1
            }
        }
        return ret
    }
}

// MARK: - Accelerate
#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

extension Image where T == Float {
    @inlinable
    public static func +(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Image) -> Image {
        var lhs = lhs
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vsub(rhs.data, 1, &lhs, 0, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
    
    @inlinable
    public static func *(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        var lhs = lhs
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_svdiv(&lhs, $0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
}

extension Image where T == Double {
    @inlinable
    public static func +(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Image) -> Image {
        var lhs = lhs
        var ret = rhs
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_vsubD(rhs.data, 1, &lhs, 0, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
    
    @inlinable
    public static func *(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var ret = rhs
        var lhs = lhs
        ret.data.withUnsafeMutableBufferPointer {
            vDSP_svdivD(&lhs, $0.baseAddress!, 1, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
        return ret
    }
}

#endif
