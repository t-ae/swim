extension MutablePixelRef where T: AdditiveArithmetic {
    @inlinable
    static func addAssign(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee += rhs
            lp += 1
        }
    }
    
    @inlinable
    static func subtractAssign(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee -= rhs
            lp += 1
        }
    }
    
    @inlinable
    public static func +=(lhs: MutablePixelRef, rhs: T) {
        addAssign(lhs: lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=(lhs: MutablePixelRef, rhs: T) {
        subtractAssign(lhs: lhs, rhs: rhs)
    }
}

extension MutablePixelRef where T: Numeric {
    @inlinable
    static func multiplyAssign(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee *= rhs
            lp += 1
        }
    }
    
    @inlinable
    public static func *=(lhs: MutablePixelRef, rhs: T) {
        multiplyAssign(lhs: lhs, rhs: rhs)
    }
}

extension MutablePixelRef where T: BinaryInteger {
    @inlinable
    static func divideAssign(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee /= rhs
            lp += 1
        }
    }
    
    @inlinable
    public static func /=(lhs: MutablePixelRef, rhs: T) {
        divideAssign(lhs: lhs, rhs: rhs)
    }
}

extension MutablePixelRef where T: FloatingPoint {
    @inlinable
    static func divideAssign(lhs: MutablePixelRef, rhs: T) {
        var lp = lhs.pointer.baseAddress!
        
        for _ in 0..<lhs.pointer.count {
            lp.pointee /= rhs
            lp += 1
        }
    }
    
    @inlinable
    public static func /=(lhs: MutablePixelRef, rhs: T) {
        divideAssign(lhs: lhs, rhs: rhs)
    }
}
