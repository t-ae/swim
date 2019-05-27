extension Pixel where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Pixel, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] += rhs
        }
    }
    
    @inlinable
    public static func +(lhs: Pixel, rhs: T) -> Pixel {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Pixel) -> Pixel {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=(lhs: inout Pixel, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] -= rhs
        }
    }
    
    @inlinable
    public static func -(lhs: Pixel, rhs: T) -> Pixel {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Pixel) -> Pixel {
        var new = rhs
        
        for i in 0..<new.data.count {
            new.data[i] = lhs - new.data[i]
        }
        
        return new
    }
}

extension Pixel where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Pixel, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] *= rhs
        }
    }
    
    @inlinable
    public static func *(lhs: Pixel, rhs: T) -> Pixel {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Pixel) -> Pixel {
        return rhs * lhs
    }
}

extension Pixel where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Pixel, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Pixel, rhs: T) -> Pixel {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Pixel) -> Pixel {
        var new = rhs
        
        for i in 0..<new.data.count {
            new.data[i] = lhs / new.data[i]
        }
        
        return new
    }
}

extension Pixel where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Pixel, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Pixel, rhs: T) -> Pixel {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Pixel) -> Pixel {
        var new = rhs
        
        for i in 0..<new.data.count {
            new.data[i] = lhs / new.data[i]
        }
        
        return new
    }
}
