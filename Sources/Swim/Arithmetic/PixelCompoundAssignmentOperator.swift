extension Pixel where T: AdditiveArithmetic {
    @inlinable
    public static func +=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] += rbp[i]
            }
        }
    }
    
    @inlinable
    public static func -=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] -= rbp[i]
            }
        }
    }
}

extension Pixel where T: Numeric {
    @inlinable
    public static func *=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] *= rbp[i]
            }
        }
    }
}

extension Pixel where T: BinaryInteger {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] /= rbp[i]
            }
        }
    }
}

extension Pixel where T: FloatingPoint {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: inout Pixel, rhs: P2) where P2.P == P, P2.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.data.count {
                lhs.data[i] /= rbp[i]
            }
        }
    }
}
