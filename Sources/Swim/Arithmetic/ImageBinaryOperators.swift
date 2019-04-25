extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /(lhs: Image<P, T>, rhs: Image<P, T>) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
}
