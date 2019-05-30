extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=<C: ColorProtocol>(lhs: inout Image, rhs: C) where C.P == P, C.T == T {
        lhs.pixelwiseConvert { ref in
            ref += rhs
        }
    }
    
    @inlinable
    public static func +<C: ColorProtocol>(lhs: Image, rhs: C) -> Image where C.P == P, C.T == T {
        return lhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = src[c] + rhs[c]
            }
        }
    }
    
    @inlinable
    public static func +<C: ColorProtocol>(lhs: C, rhs: Image) -> Image where C.P == P, C.T == T {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=<C: ColorProtocol>(lhs: inout Image, rhs: C) where C.P == P, C.T == T {
        lhs.pixelwiseConvert { ref in
            ref -= rhs
        }
    }
    
    @inlinable
    public static func -<C: ColorProtocol>(lhs: Image, rhs: C) -> Image where C.P == P, C.T == T {
        return lhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = src[c] - rhs[c]
            }
        }
    }
    
    @inlinable
    public static func -<C: ColorProtocol>(lhs: C, rhs: Image) -> Image where C.P == P, C.T == T {
        return rhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = lhs[c] - src[c]
            }
        }
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *=<C: ColorProtocol>(lhs: inout Image, rhs: C) where C.P == P, C.T == T {
        lhs.pixelwiseConvert { ref in
            ref *= rhs
        }
    }
    
    @inlinable
    public static func *<C: ColorProtocol>(lhs: Image, rhs: C) -> Image where C.P == P, C.T == T {
        return lhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = src[c] * rhs[c]
            }
        }
    }
    
    @inlinable
    public static func *<C: ColorProtocol>(lhs: C, rhs: Image) -> Image where C.P == P, C.T == T {
        return rhs * lhs
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=<C: ColorProtocol>(lhs: inout Image, rhs: C) where C.P == P, C.T == T {
        lhs.pixelwiseConvert { ref in
            ref /= rhs
        }
    }
    
    @inlinable
    public static func /<C: ColorProtocol>(lhs: Image, rhs: C) -> Image where C.P == P, C.T == T {
        return lhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = src[c] / rhs[c]
            }
        }
    }
    
    @inlinable
    public static func /<C: ColorProtocol>(lhs: C, rhs: Image) -> Image where C.P == P, C.T == T {
        return rhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = lhs[c] / src[c]
            }
        }
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /=<C: ColorProtocol>(lhs: inout Image, rhs: C) where C.P == P, C.T == T {
        lhs.pixelwiseConvert { ref in
            ref /= rhs
        }
    }
    
    @inlinable
    public static func /<C: ColorProtocol>(lhs: Image, rhs: C) -> Image where C.P == P, C.T == T {
        return lhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = src[c] / rhs[c]
            }
        }
    }
    
    @inlinable
    public static func /<C: ColorProtocol>(lhs: C, rhs: Image) -> Image where C.P == P, C.T == T {
        return rhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = lhs[c] / src[c]
            }
        }
    }
}
