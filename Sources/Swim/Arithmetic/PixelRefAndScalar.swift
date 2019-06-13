extension UnsafePixelRef where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: UnsafePixelRef, rhs: T) {
        for i in 0..<P.channels {
            lhs.pointer[i] += rhs
        }
    }
    
    @inlinable
    public static func -=(lhs: UnsafePixelRef, rhs: T) {
        for i in 0..<P.channels {
            lhs.pointer[i] -= rhs
        }
    }
}

extension UnsafePixelRef where T: Numeric {
    @inlinable
    public static func *=(lhs: UnsafePixelRef, rhs: T) {
        for i in 0..<P.channels {
            lhs.pointer[i] *= rhs
        }
    }
}

extension UnsafePixelRef where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: UnsafePixelRef, rhs: T) {
        for i in 0..<P.channels {
            lhs.pointer[i] /= rhs
        }
    }
}

extension UnsafePixelRef where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: UnsafePixelRef, rhs: T) {
        for i in 0..<P.channels {
            lhs.pointer[i] /= rhs
        }
    }
}

// MARK: - Utility

extension UnsafePixelRef {
    /// Fill with given value.
    @inlinable
    public func fill(value: T) {
        for i in 0..<P.channels {
            pointer[i] = value
        }
    }
}
