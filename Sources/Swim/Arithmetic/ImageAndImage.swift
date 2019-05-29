extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Image, rhs: Image) {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        for i in 0..<lhs.data.count {
            lhs.data[i] += rhs.data[i]
        }
    }
    
    @inlinable
    public static func +(lhs: Image, rhs: Image) -> Image {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] + rhs.data[i]
            }
        }
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: Image) {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        for i in 0..<lhs.data.count {
            lhs.data[i] -= rhs.data[i]
        }
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: Image) -> Image {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] - rhs.data[i]
            }
        }
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Image, rhs: Image) {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        for i in 0..<lhs.data.count {
            lhs.data[i] *= rhs.data[i]
        }
    }
    
    @inlinable
    public static func *(lhs: Image, rhs: Image) -> Image {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] * rhs.data[i]
            }
        }
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Image<P, T>, rhs: Image<P, T>) {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs.data[i]
        }
    }
    
    @inlinable
    public static func /(lhs: Image<P, T>, rhs: Image<P, T>) -> Image<P, T> {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] / rhs.data[i]
            }
        }
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Image<P, T>, rhs: Image<P, T>) {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs.data[i]
        }
    }
    
    @inlinable
    public static func /(lhs: Image, rhs: Image) -> Image {
        precondition(lhs.size == rhs.size, "Size mismatch.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] / rhs.data[i]
            }
        }
    }
}
