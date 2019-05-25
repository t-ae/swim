extension DataContainer where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] += rhs
            }
        }
    }
    
    @inlinable
    public static func +(lhs: Self, rhs: T) -> Self {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Self) -> Self {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] -= rhs
            }
        }
    }
    
    @inlinable
    public static func -(lhs: Self, rhs: T) -> Self {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Self) -> Self {
        var new = rhs
        new.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] = lhs - bp[i]
            }
        }
        return new
    }
}

extension DataContainer where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] *= rhs
            }
        }
    }
    
    @inlinable
    public static func *(lhs: Self, rhs: T) -> Self {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Self) -> Self {
        return rhs * lhs
    }
}

extension DataContainer where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] /= rhs
            }
        }
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: T) -> Self {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Self) -> Self {
        var new = rhs
        new.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] = lhs / bp[i]
            }
        }
        return new
    }
}

extension DataContainer where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] /= rhs
            }
        }
    }
    
    @inlinable
    public static func /(lhs: Self, rhs: T) -> Self {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Self) -> Self {
        var new = rhs
        new.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] = lhs / bp[i]
            }
        }
        return new
    }
}
