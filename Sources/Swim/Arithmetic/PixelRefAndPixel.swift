import Foundation

extension PixelRef where T: AdditiveArithmetic {
    @inlinable
    public static func +=<C: ColorProtocol>(lhs: PixelRef, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] += rhs[i]
        }
    }
    
    @inlinable
    public static func -=<C: ColorProtocol>(lhs: PixelRef, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] -= rhs[i]
        }
    }
}

extension PixelRef where T: Numeric {
    @inlinable
    public static func *=<C: ColorProtocol>(lhs: PixelRef, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] *= rhs[i]
        }
    }
}

extension PixelRef where T: BinaryInteger {
    @inlinable
    public static func /=<C: ColorProtocol>(lhs: PixelRef, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] /= rhs[i]
        }
    }
}

extension PixelRef where T: FloatingPoint {
    @inlinable
    public static func /=<C: ColorProtocol>(lhs: PixelRef, rhs: C) where C.P == P, C.T == T {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] /= rhs[i]
        }
    }
}

// MARK: - Utility

extension PixelRef {
    /// Set color.
    ///
    /// It's convenient implementation of:
    ///
    /// for c in 0..<P.channels { self[c] = color[c] }
    @inlinable
    public func setColor<C: ColorProtocol>(color: C) where C.P == P, C.T == T {
        for i in 0..<pointer.count {
            pointer[i] = color[i]
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
        for i in 0..<pointer.count {
            pointer[i] = image.data[start + i]
        }
    }
}

extension PixelRef where T: Numeric {
    /// Set color with multiply factor.
    ///
    /// It's convenient implementation of:
    ///
    /// for c in 0..<P.channels { self[c] = factor * color[c] }
    @inlinable
    func setColor<C: ColorProtocol>(color: C, with factor: T) where C.P == P, C.T == T {
        for i in 0..<pointer.count {
            pointer[i] = color[i] * factor
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
        for i in 0..<pointer.count {
            pointer[i] = image.data[start+i] * factor
        }
    }
    
    /// Add color with multiply factor.
    ///
    /// It's convenient implementation of:
    ///
    /// for c in 0..<P.channels { self[c] += factor * color[c] }
    @inlinable
    func addColor<C: ColorProtocol>(color: C, with factor: T = 1) where C.P == P, C.T == T {
        for i in 0..<pointer.count {
            pointer[i] += color[i] * factor
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
        for i in 0..<pointer.count {
            pointer[i] += image.data[start+i] * factor
        }
    }
}
