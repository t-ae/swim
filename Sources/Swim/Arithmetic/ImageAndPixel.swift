extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
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
    public static func +<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new += rhs
        return new
    }
    
    @inlinable
    public static func +<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
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
    public static func -<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new -= rhs
        return new
    }
    
    @inlinable
    public static func -<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
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
    public static func *=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
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
    public static func *<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new *= rhs
        return new
    }
    
    @inlinable
    public static func *<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
        return rhs * lhs
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
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
    public static func /<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
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
    public static func /=<Px: PixelProtocol>(lhs: inout Image, rhs: Px) where Px.P == P, Px.T == T {
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
    public static func /<Px: PixelProtocol>(lhs: Image, rhs: Px) -> Image where Px.P == P, Px.T == T {
        var new = lhs
        new /= rhs
        return new
    }
    
    @inlinable
    public static func /<Px: PixelProtocol>(lhs: Px, rhs: Image) -> Image where Px.P == P, Px.T == T {
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
