extension Color where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] += rhs
        }
    }
    
    @inlinable
    public static func +(lhs: Color, rhs: T) -> Color {
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs[i] + rhs)
                p += 1
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
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs[i] - rhs)
                p += 1
            }
        }
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs - rhs[i])
                p += 1
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
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs[i] * rhs)
                p += 1
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
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs[i] / rhs)
                p += 1
            }
        }
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs / rhs[i])
                p += 1
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
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs[i] / rhs)
                p += 1
            }
        }
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs / rhs[i])
                p += 1
            }
        }
    }
}

extension Color where T: ComplexProtocol {
    @inlinable
    public static func /=(lhs: inout Color, rhs: T) {
        for i in 0..<P.channels {
            lhs[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Color, rhs: T) -> Color {
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs[i] / rhs)
                p += 1
            }
        }
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: lhs / rhs[i])
                p += 1
            }
        }
    }
}
