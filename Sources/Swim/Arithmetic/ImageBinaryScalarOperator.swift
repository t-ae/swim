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
