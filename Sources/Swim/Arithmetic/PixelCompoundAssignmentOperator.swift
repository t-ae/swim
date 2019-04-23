extension Pixel where T: AdditiveArithmetic {
    @inlinable
    static func addAssign<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        lhs.data.withUnsafeMutableBufferPointer { lbp in
            var lp = lbp.baseAddress!
            rhs.withUnsafeBufferPointer { rbp in
                assert(lbp.count == rbp.count)
                
                var rp = rbp.baseAddress!
                for _ in 0..<lbp.count {
                    lp.pointee += rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    static func subtractAssign<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        lhs.data.withUnsafeMutableBufferPointer { lbp in
            var lp = lbp.baseAddress!
            rhs.withUnsafeBufferPointer { rbp in
                assert(lbp.count == rbp.count)
                
                var rp = rbp.baseAddress!
                for _ in 0..<lbp.count {
                    lp.pointee -= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    public static func +=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where T: Numeric {
    @inlinable
    static func multiplyAssign<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        lhs.data.withUnsafeMutableBufferPointer { lbp in
            var lp = lbp.baseAddress!
            rhs.withUnsafeBufferPointer { rbp in
                assert(lbp.count == rbp.count)
                
                var rp = rbp.baseAddress!
                for _ in 0..<lbp.count {
                    lp.pointee *= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    public static func *=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where T: BinaryInteger {
    @inlinable
    static func divideAssign<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        lhs.data.withUnsafeMutableBufferPointer { lbp in
            var lp = lbp.baseAddress!
            rhs.withUnsafeBufferPointer { rbp in
                assert(lbp.count == rbp.count)
                
                var rp = rbp.baseAddress!
                for _ in 0..<lbp.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where T: FloatingPoint {
    @inlinable
    static func divideAssign<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        lhs.data.withUnsafeMutableBufferPointer { lbp in
            var lp = lbp.baseAddress!
            rhs.withUnsafeBufferPointer { rbp in
                assert(lbp.count == rbp.count)
                
                var rp = rbp.baseAddress!
                for _ in 0..<lbp.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}
