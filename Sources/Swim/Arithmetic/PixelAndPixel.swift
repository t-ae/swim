import Foundation

extension Pixel where T: AdditiveArithmetic {
    @inlinable
    public static func +=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] += rbp[i]
            }
        }
    }
    
    // need this to disambiguate pixel + pixel
    @inlinable
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +<P2: PixelProtocol>(lhs: Pixel, rhs: P2) -> Pixel where P2.P == P, P2.T == T {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +<P2: PixelProtocol>(lhs: P2, rhs: Pixel) -> Pixel where P2.P == P, P2.T == T {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] -= rbp[i]
            }
        }
    }
    
    // need this to disambiguate pixel - pixel
    @inlinable
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -<P2: PixelProtocol>(lhs: Pixel, rhs: P2) -> Pixel where P2.P == P, P2.T == T {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -<P2: PixelProtocol>(lhs: P2, rhs: Pixel) -> Pixel where P2.P == P, P2.T == T {
        var new = rhs
        
        lhs.withUnsafeBufferPointer { rbp in
            for i in 0..<new.data.count {
                new.data[i] = new.data[i] - rbp[i]
            }
        }
        
        return rhs
    }
}

extension Pixel where T: Numeric {
    @inlinable
    public static func *=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] *= rbp[i]
            }
        }
    }
    
    // need this to disambiguate pixel * pixel
    @inlinable
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *<P2: PixelProtocol>(lhs: Pixel, rhs: P2) -> Pixel where P2.P == P, P2.T == T {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *<P2: PixelProtocol>(lhs: P2, rhs: Pixel) -> Pixel where P2.P == P, P2.T == T {
        return rhs * lhs
    }
}

extension Pixel where T: BinaryInteger {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] /= rbp[i]
            }
        }
    }
    
    // need this to disambiguate pixel / pixel
    @inlinable
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: Pixel, rhs: P2) -> Pixel where P2.P == P, P2.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: P2, rhs: Pixel) -> Pixel where P2.P == P, P2.T == T {
        var new = rhs
        
        lhs.withUnsafeBufferPointer { rbp in
            for i in 0..<new.data.count {
                new.data[i] = new.data[i] / rbp[i]
            }
        }
        
        return rhs
    }
}

extension Pixel where T: BinaryFloatingPoint {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] /= rbp[i]
            }
        }
    }
    
    // need this to disambiguate pixel / pixel
    @inlinable
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: Pixel, rhs: P2) -> Pixel where P2.P == P, P2.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: P2, rhs: Pixel) -> Pixel where P2.P == P, P2.T == T {
        var new = rhs
        
        lhs.withUnsafeBufferPointer { rbp in
            for i in 0..<new.data.count {
                new.data[i] = new.data[i] / rbp[i]
            }
        }
        
        return rhs
    }
}
