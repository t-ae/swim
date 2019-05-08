import Foundation

extension MutablePixelRef where T: AdditiveArithmetic {
    @inlinable
    public static func +=<P2: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!
            for _ in 0..<P.channels {
                lp.pointee += rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    public static func -=<P2: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!
            for _ in 0..<P.channels {
                lp.pointee -= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
}

extension MutablePixelRef where T: Numeric {
    @inlinable
    public static func *=<P2: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!
            for _ in 0..<P.channels {
                lp.pointee *= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
}

extension MutablePixelRef where T: BinaryInteger {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!
            for _ in 0..<P.channels {
                lp.pointee /= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
}

extension MutablePixelRef where T: FloatingPoint {
    @inlinable
    public static func /=<P2: PixelProtocol>(lhs: MutablePixelRef,
                                             rhs: P2) where P2.P == P, P2.T == T {
        var lp = lhs.pointer.baseAddress!
        rhs.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!
            for _ in 0..<P.channels {
                lp.pointee /= rp.pointee
                lp += 1
                rp += 1
            }
        }
    }
}

// MARK: - Utility

extension MutablePixelRef {
    @inlinable
    func assign<P2: PixelProtocol>(pixel: P2) where P2.P == P, P2.T == T {
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
    func add<P2: PixelProtocol>(pixel: P2, with factor: T = 1) where P2.P == P, P2.T == T {
        var lp = self.pointer.baseAddress!
        pixel.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!
            for _ in 0..<P.channels {
                lp.pointee += rp.pointee * factor
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    func add(x: Int, y: Int, in image: Image<P, T>, with factor: T = 1) {
        var lp = self.pointer.baseAddress!
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!.advanced(by: start)
            for _ in 0..<P.channels {
                lp.pointee += rp.pointee * factor
                lp += 1
                rp += 1
            }
        }
    }
    
    @inlinable
    func assign<P2: PixelProtocol>(pixel: P2, with factor: T) where P2.P == P, P2.T == T {
        var lp = self.pointer.baseAddress!
        pixel.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!
            for _ in 0..<P.channels {
                lp.pointee = rp.pointee * factor
                lp += 1
                rp += 1
            }
        }
    }

    @inlinable
    func assign(x: Int,y: Int, in image: Image<P, T>, with factor: T) {
        var lp = self.pointer.baseAddress!
        let start = image.dataIndex(x: x, y: y)
        image.withUnsafeBufferPointer { rbp in
            var rp = rbp.baseAddress!.advanced(by: start)
            for _ in 0..<P.channels {
                lp.pointee = rp.pointee * factor
                lp += 1
                rp += 1
            }
        }
    }
}


