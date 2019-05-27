extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
        lhs.pixelwiseConvert { ref in
            ref += rhs
        }
    }
    
    @inlinable
    public static func +<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
        lhs.pixelwiseConvert { ref in
            ref -= rhs
        }
    }
    
    @inlinable
    public static func -<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
        return rhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = lhs[c] - src[c]
            }
        }
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
        lhs.pixelwiseConvert { ref in
            ref *= rhs
        }
    }
    
    @inlinable
    public static func *<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
        return rhs * lhs
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
        lhs.pixelwiseConvert { ref in
            ref /= rhs
        }
    }
    
    @inlinable
    public static func /<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
        return rhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = lhs[c] / src[c]
            }
        }
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
        lhs.pixelwiseConvert { ref in
            ref /= rhs
        }
    }
    
    @inlinable
    public static func /<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
        return rhs.pixelwiseConverted { src, dst in
            for c in 0..<P.channels {
                dst[c] = lhs[c] / src[c]
            }
        }
    }
}
