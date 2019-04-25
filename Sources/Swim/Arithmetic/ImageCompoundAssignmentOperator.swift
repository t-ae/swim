extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Image, rhs: Image) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee += rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
    
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: Image) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee -= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Image, rhs: Image) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee *= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Image<P, T>, rhs: Image<P, T>) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Image, rhs: Image) {
        precondition(lhs.data.count == rhs.data.count, "Size mismatch.")
        lhs.data.withUnsafeMutableBufferPointer {
            var lp = $0.baseAddress!
            rhs.data.withUnsafeBufferPointer {
                var rp = $0.baseAddress!
                for _ in 0..<$0.count {
                    lp.pointee /= rp.pointee
                    lp += 1
                    rp += 1
                }
            }
        }
    }
}
