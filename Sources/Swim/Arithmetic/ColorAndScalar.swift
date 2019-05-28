extension Color where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] += rhs
        }
    }
    
    @inlinable
    public static func +(lhs: Color, rhs: T) -> Color {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Color) -> Color {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] -= rhs
        }
    }
    
    @inlinable
    public static func -(lhs: Color, rhs: T) -> Color {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Color) -> Color {
        var new = rhs
        
        for i in 0..<P.channels {
            new[i] = lhs - new[i]
        }
        
        return new
    }
}

extension Color where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] *= rhs
        }
    }
    
    @inlinable
    public static func *(lhs: Color, rhs: T) -> Color {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Color) -> Color {
        return rhs * lhs
    }
}

extension Color where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Color, rhs: T) -> Color {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Color) -> Color {
        var new = rhs
        
        for i in 0..<P.channels {
            new[i] = lhs / new[i]
        }
        
        return new
    }
}

extension Color where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Color, rhs: T) -> Color {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Color) -> Color {
        var new = rhs
        
        for i in 0..<new.data.count {
            new.data[i] = lhs / new.data[i]
        }
        
        return new
    }
}
