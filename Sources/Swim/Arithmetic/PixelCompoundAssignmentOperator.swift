extension Pixel where T: AdditiveArithmetic {
    @inlinable
    public static func +=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
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
    public static func -=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
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
}

extension Pixel where T: Numeric {
    @inlinable
    public static func *=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
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
}

extension Pixel where T: BinaryInteger {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
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
}

extension Pixel where T: FloatingPoint {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
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
}
