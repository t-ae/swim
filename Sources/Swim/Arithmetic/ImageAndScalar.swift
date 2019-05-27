extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] += rhs
        }
    }
    
    @inlinable
    public static func +(lhs: Image, rhs: T) -> Image {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Image) -> Image {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] -= rhs
        }
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: T) -> Image {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Image) -> Image {
        var new = rhs
        
        for i in 0..<new.data.count {
            new.data[i] = lhs - new.data[i]
        }
        
        return new
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] *= rhs
        }
    }
    
    @inlinable
    public static func *(lhs: Image, rhs: T) -> Image {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Image) -> Image {
        return rhs * lhs
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var new = rhs
        
        for i in 0..<new.data.count {
            new.data[i] = lhs / new.data[i]
        }
        
        return new
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var new = rhs
        
        for i in 0..<new.data.count {
            new.data[i] = lhs / new.data[i]
        }
        
        return new
    }
}
