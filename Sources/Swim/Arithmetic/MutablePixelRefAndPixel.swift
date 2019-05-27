import Foundation

extension MutablePixelRef where T: AdditiveArithmetic {
    @inlinable
    public static func +=<Px: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: Px) where Px.P == P, Px.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.pointer.count {
                lhs.pointer[i] += rbp[i]
            }
        }
    }
    
    @inlinable
    public static func -=<Px: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: Px) where Px.P == P, Px.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.pointer.count {
                lhs.pointer[i] -= rbp[i]
            }
        }
    }
}

extension MutablePixelRef where T: Numeric {
    @inlinable
    public static func *=<Px: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: Px) where Px.P == P, Px.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.pointer.count {
                lhs.pointer[i] *= rbp[i]
            }
        }
    }
}

extension MutablePixelRef where T: BinaryInteger {
    @inlinable
    public static func /=<Px: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: Px) where Px.P == P, Px.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.pointer.count {
                lhs.pointer[i] /= rbp[i]
            }
        }
    }
}

extension MutablePixelRef where T: FloatingPoint {
    @inlinable
    public static func /=<Px: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: Px) where Px.P == P, Px.T == T {
        rhs.withUnsafeBufferPointer { rbp in
            for i in 0..<lhs.pointer.count {
                lhs.pointer[i] /= rbp[i]
            }
        }
    }
}

// MARK: - Utility

extension MutablePixelRef {
    /// Set color.
    ///
    /// It's convenient implementation of:
    ///
    /// for c in 0..<P.channels { self[c] = pixel[c] }
    @inlinable
    public func setColor<Px: PixelProtocol>(pixel: Px) where Px.P == P, Px.T == T {
        pixel.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] = rbp[i]
            }
        }
    }
    
    /// Set color of `image[x, y]`.
    ///
    /// It's convenient and faster implementation of:
    ///
    /// for c in 0..<P.channels { self[c] = image[x, y, c] }
    @inlinable
    public func setColor(x: Int,y: Int, in image: Image<P, T>) {
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] = rbp[start + i]
            }
        }
    }
}

extension MutablePixelRef where T: Numeric {
    /// Set color with multiply factor.
    ///
    /// It's convenient implementation of:
    ///
    /// for c in 0..<P.channels { self[c] = factor * pixel[c] }
    @inlinable
    func setColor<Px: PixelProtocol>(pixel: Px, with factor: T) where Px.P == P, Px.T == T {
        pixel.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] = rbp[i] * factor
            }
        }
    }
    
    /// Set color with multiply factor.
    ///
    /// It's convenient and faster implementation of:
    ///
    /// for c in 0..<P.channels { self[c] += factor * image[x, y, c] }
    @inlinable
    func setColor(x: Int,y: Int, in image: Image<P, T>, with factor: T) {
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] = rbp[start+i] * factor
            }
        }
    }
    
    /// Add color with multiply factor.
    ///
    /// It's convenient implementation of:
    ///
    /// for c in 0..<P.channels { self[c] += factor * pixel[c] }
    @inlinable
    func addColor<Px: PixelProtocol>(pixel: Px, with factor: T = 1) where Px.P == P, Px.T == T {
        pixel.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] += rbp[i] * factor
            }
        }
    }
    
    /// Add color with multiply factor.
    ///
    /// It's convenient and faster implementation of:
    ///
    /// for c in 0..<P.channels { self[c] += factor * image[x, y, c] }
    @inlinable
    public func addColor(x: Int, y: Int, in image: Image<P, T>, with factor: T = 1) {
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] += rbp[start+i] * factor
            }
        }
    }
}
