extension DataContainer where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
}

extension DataContainer where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee *= rhs
                p += 1
            }
        }
    }
}

extension DataContainer where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
}

extension DataContainer where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
}
