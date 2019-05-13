extension PixelProtocol where T: AdditiveArithmetic {
    @inlinable
    public static func +(lhs: Self, rhs: T) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(from: lhs)
        pixel += rhs
        return pixel
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Self) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(value: lhs)
        pixel += rhs
        return pixel
    }
    
    @inlinable
    public static func -(lhs: Self, rhs: T) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(from: lhs)
        pixel -= rhs
        return pixel
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Self) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(value: lhs)
        pixel -= rhs
        return pixel
    }
}

extension PixelProtocol where T: Numeric {
    @inlinable
    public static func *(lhs: Self, rhs: T) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(from: lhs)
        pixel *= rhs
        return pixel
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Self) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(value: lhs)
        pixel *= rhs
        return pixel
    }
}

extension PixelProtocol where T: BinaryInteger {
    @inlinable
    public static func /(lhs: Self, rhs: T) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(from: lhs)
        pixel /= rhs
        return pixel
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Self) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(value: lhs)
        pixel /= rhs
        return pixel
    }
}

extension PixelProtocol where T: FloatingPoint {
    @inlinable
    public static func /(lhs: Self, rhs: T) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(from: lhs)
        pixel /= rhs
        return pixel
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Self) -> Pixel<P, T> {
        var pixel = Pixel<P, T>(value: lhs)
        pixel /= rhs
        return pixel
    }
}
