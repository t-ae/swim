import Foundation

extension Pixel where T: AdditiveArithmetic {
    @inlinable
    public static func +=<C: ColorProtocol>(lhs: inout Pixel, rhs: C) where C.P == P, C.T == T {
        for i in 0..<P.channels {
            lhs[i] += rhs[i]
        }
    }
    
    @inlinable
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func -=<C: ColorProtocol>(lhs: inout Pixel, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.data.count {
            lhs.data[i] -= rhs[i]
        }
    }
    
    @inlinable
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new -= rhs
        return new
    }
}

extension Pixel where T: Numeric {
    @inlinable
    public static func *=<C: ColorProtocol>(lhs: inout Pixel, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.data.count {
            lhs.data[i] *= rhs[i]
        }
    }
    
    @inlinable
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new *= rhs
        return new
    }
}

extension Pixel where T: BinaryInteger {
    @inlinable
    public static func /=<C: ColorProtocol>(lhs: inout Pixel, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs[i]
        }
    }
    
    @inlinable
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new /= rhs
        return new
    }
}

extension Pixel where T: BinaryFloatingPoint {
    @inlinable
    public static func /=<C: ColorProtocol>(lhs: inout Pixel, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs[i]
        }
    }
    
    @inlinable
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new /= rhs
        return new
    }
}
