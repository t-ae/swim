extension Color where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] += rhs
        }
    }
    
    @inlinable
    public static func +(lhs: Color, rhs: T) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs[i] + rhs
            }
        }
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Color) -> Color {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] -= rhs
        }
    }
    
    @inlinable
    public static func -(lhs: Color, rhs: T) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs[i] - rhs
            }
        }
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs - rhs[i]
            }
        }
    }
}

extension Color where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] *= rhs
        }
    }
    
    @inlinable
    public static func *(lhs: Color, rhs: T) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs[i] * rhs
            }
        }
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Color) -> Color {
        return rhs * lhs
    }
}

extension Color where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Color, rhs: T) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs[i] / rhs
            }
        }
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs / rhs[i]
            }
        }
    }
}

extension Color where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Color, rhs: T) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs[i] / rhs
            }
        }
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = lhs / rhs[i]
            }
        }
    }
}
