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
    public static func -=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] -= rhs
            }
        }
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
}
