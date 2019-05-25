extension MutablePixelRef where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: MutablePixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] += rhs
        }
    }
    
    @inlinable
    public static func -=(lhs: MutablePixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] -= rhs
        }
    }
}

extension MutablePixelRef where T: Numeric {
    @inlinable
    public static func *=(lhs: MutablePixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] *= rhs
        }
    }
}

extension MutablePixelRef where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: MutablePixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] /= rhs
        }
    }
}

extension MutablePixelRef where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: MutablePixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] /= rhs
        }
    }
}
