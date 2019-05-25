extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=<P2: PixelProtocol>(lhs: inout Image, rhs: P2) where P2.P == P, P2.T == T {
        lhs.withUnsafeMutableBufferPointer { lbp in
            rhs.withUnsafeBufferPointer { rbp in
                for li in stride(from: 0, to: lbp.count, by: rbp.count) {
                    for ri in 0..<rbp.count {
                        lbp[li+ri] += rbp[ri]
                    }
                }
            }
        }
    }
    
    @inlinable
    public static func +<P2: PixelProtocol>(lhs: Image, rhs: P2) -> Image where P2.P == P, P2.T == T {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +<P2: PixelProtocol>(lhs: P2, rhs: Image) -> Image where P2.P == P, P2.T == T {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=<P2: PixelProtocol>(lhs: inout Image, rhs: P2) where P2.P == P, P2.T == T {
        lhs.withUnsafeMutableBufferPointer { lbp in
            rhs.withUnsafeBufferPointer { rbp in
                for li in stride(from: 0, to: lbp.count, by: rbp.count) {
                    for ri in 0..<rbp.count {
                        lbp[li+ri] -= rbp[ri]
                    }
                }
            }
        }
    }
    
    @inlinable
    public static func -<P2: PixelProtocol>(lhs: Image, rhs: P2) -> Image where P2.P == P, P2.T == T {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -<P2: PixelProtocol>(lhs: P2, rhs: Image) -> Image where P2.P == P, P2.T == T {
        var new = rhs
        
        lhs.withUnsafeBufferPointer { lbp in
            new.withUnsafeMutableBufferPointer { rbp in
                for ri in stride(from: 0, to: rbp.count, by: lbp.count) {
                    for li in 0..<lbp.count {
                        rbp[ri+li] = lbp[li] - rbp[ri+li]
                    }
                }
            }
        }
        
        return new
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *=<P2: PixelProtocol>(lhs: inout Image, rhs: P2) where P2.P == P, P2.T == T {
        lhs.withUnsafeMutableBufferPointer { lbp in
            rhs.withUnsafeBufferPointer { rbp in
                for li in stride(from: 0, to: lbp.count, by: rbp.count) {
                    for ri in 0..<rbp.count {
                        lbp[li+ri] *= rbp[ri]
                    }
                }
            }
        }
    }
    
    @inlinable
    public static func *<P2: PixelProtocol>(lhs: Image, rhs: P2) -> Image where P2.P == P, P2.T == T {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *<P2: PixelProtocol>(lhs: P2, rhs: Image) -> Image where P2.P == P, P2.T == T {
        return rhs * lhs
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Image, rhs: P2) where P2.P == P, P2.T == T {
        lhs.withUnsafeMutableBufferPointer { lbp in
            rhs.withUnsafeBufferPointer { rbp in
                for li in stride(from: 0, to: lbp.count, by: rbp.count) {
                    for ri in 0..<rbp.count {
                        lbp[li+ri] /= rbp[ri]
                    }
                }
            }
        }
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: Image, rhs: P2) -> Image where P2.P == P, P2.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: P2, rhs: Image) -> Image where P2.P == P, P2.T == T {
        var new = rhs
        
        lhs.withUnsafeBufferPointer { lbp in
            new.withUnsafeMutableBufferPointer { rbp in
                for ri in stride(from: 0, to: rbp.count, by: lbp.count) {
                    for li in 0..<lbp.count {
                        rbp[ri+li] = lbp[li] / rbp[ri+li]
                    }
                }
            }
        }
        
        return new
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Image, rhs: P2) where P2.P == P, P2.T == T {
        lhs.withUnsafeMutableBufferPointer { lbp in
            rhs.withUnsafeBufferPointer { rbp in
                for li in stride(from: 0, to: lbp.count, by: rbp.count) {
                    for ri in 0..<rbp.count {
                        lbp[li+ri] /= rbp[ri]
                    }
                }
            }
        }
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: Image, rhs: P2) -> Image where P2.P == P, P2.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<P2: PixelProtocol>(lhs: P2, rhs: Image) -> Image where P2.P == P, P2.T == T {
        var new = rhs
        
        lhs.withUnsafeBufferPointer { lbp in
            new.withUnsafeMutableBufferPointer { rbp in
                for ri in stride(from: 0, to: rbp.count, by: lbp.count) {
                    for li in 0..<lbp.count {
                        rbp[ri+li] = lbp[li] / rbp[ri+li]
                    }
                }
            }
        }
        
        return new
    }
}
