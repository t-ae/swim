import Foundation

extension MutablePixelRef where T: AdditiveArithmetic {
    @inlinable
    static func addAssign<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            assert(lhs.pointer.count == rbp.count)
            
            var rp = rbp.baseAddress!
            for _ in 0..<lhs.pointer.count {
                lp.pointee += rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    static func subtractAssign<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            assert(lhs.pointer.count == rbp.count)
            
            var rp = rbp.baseAddress!
            for _ in 0..<lhs.pointer.count {
                lp.pointee -= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    public static func +=<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        addAssign(lhs: lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        subtractAssign(lhs: lhs, rhs: rhs)
    }
}

extension MutablePixelRef where T: Numeric {
    @inlinable
    static func multiplyAssign<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            assert(lhs.pointer.count == rbp.count)
            
            var rp = rbp.baseAddress!
            for _ in 0..<lhs.pointer.count {
                lp.pointee *= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    public static func *=<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        multiplyAssign(lhs: lhs, rhs: rhs)
    }
}

extension MutablePixelRef where T: BinaryInteger {
    @inlinable
    static func divideAssign<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            assert(lhs.pointer.count == rbp.count)
            
            var rp = rbp.baseAddress!
            for _ in 0..<lhs.pointer.count {
                lp.pointee /= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        divideAssign(lhs: lhs, rhs: rhs)
    }
}

extension MutablePixelRef where T: FloatingPoint {
    @inlinable
    static func divideAssign<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            assert(lhs.pointer.count == rbp.count)
            
            var rp = rbp.baseAddress!
            for _ in 0..<lhs.pointer.count {
                lp.pointee /= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: MutablePixelRef, rhs: P2) where P2.P == P, P2.T == T {
        divideAssign(lhs: lhs, rhs: rhs)
    }
}

// MARK: - Utility

extension MutablePixelRef where T: Numeric {
    @inlinable
    func add<P2: PixelProtocol>(pixel: P2, with factor: T) where P2.P == P, P2.T == T {
        var lp = self.pointer.baseAddress!
        pixel.withUnsafeBufferPointer { rbp in
            assert(self.pointer.count == rbp.count)
            
            var rp = rbp.baseAddress!
            for _ in 0..<self.pointer.count {
                lp.pointee += rp.pointee * factor
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    func assign<P2: PixelProtocol>(pixel: P2) where P2.P == P, P2.T == T {
        let lp = self.pointer.baseAddress!
        pixel.withUnsafeBufferPointer { rbp in
            assert(self.pointer.count == rbp.count)
            let rp = rbp.baseAddress!
            memcpy(lp, rp, MemoryLayout<T>.size*self.pointer.count)
        }
    }
}
