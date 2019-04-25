extension MutablePixelRef where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee += rhs
            lp += 1
        }
    }
    
    @inlinable
    public static func -=(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee -= rhs
            lp += 1
        }
    }
}

extension MutablePixelRef where T: Numeric {
    @inlinable
    public static func *=(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee *= rhs
            lp += 1
        }
    }
}

extension MutablePixelRef where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee /= rhs
            lp += 1
        }
    }
}

extension MutablePixelRef where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee /= rhs
            lp += 1
        }
    }
}
