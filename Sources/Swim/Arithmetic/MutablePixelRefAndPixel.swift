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
    @inlinable
    func assign<Px: PixelProtocol>(pixel: Px) where Px.P == P, Px.T == T {
        let lp = self.pointer.baseAddress!
        pixel.withUnsafeBufferPointer { rbp in
            let rp = rbp.baseAddress!
            memcpy(lp, rp, P.channels * MemoryLayout<T>.size)
        }
    }
    
    @inlinable
    func assign(x: Int,y: Int, in image: Image<P, T>) {
        let lp = self.pointer.baseAddress!
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            let rp = rbp.baseAddress!.advanced(by: start)
            memcpy(lp, rp, P.channels * MemoryLayout<T>.size)
        }
    }
}

extension MutablePixelRef where T: Numeric {
    @inlinable
    func add<Px: PixelProtocol>(pixel: Px, with factor: T = 1) where Px.P == P, Px.T == T {
        pixel.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] += rbp[i] * factor
            }
        }
    }
    
    @inlinable
    func add(x: Int, y: Int, in image: Image<P, T>, with factor: T = 1) {
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] += rbp[start+i] * factor
            }
        }
    }
    
    @inlinable
    func assign<Px: PixelProtocol>(pixel: Px, with factor: T) where Px.P == P, Px.T == T {
        pixel.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] = rbp[i] * factor
            }
        }
    }

    @inlinable
    func assign(x: Int,y: Int, in image: Image<P, T>, with factor: T) {
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            for i in 0..<pointer.count {
                pointer[i] = rbp[start+i] * factor
            }
        }
    }
}
