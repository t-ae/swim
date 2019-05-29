extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] += rhs
        }
    }
    
    @inlinable
    public static func +(lhs: Image, rhs: T) -> Image {
        return lhs.dataConverted {
            $0 + rhs
        }
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Image) -> Image {
        return rhs + lhs
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] -= rhs
        }
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: T) -> Image {
        return lhs.dataConverted {
            $0 - rhs
        }
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Image) -> Image {
        return rhs.dataConverted {
            lhs - $0
        }
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] *= rhs
        }
    }
    
    @inlinable
    public static func *(lhs: Image, rhs: T) -> Image {
        return lhs.dataConverted {
            $0 * rhs
        }
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Image) -> Image {
        return rhs * lhs
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        return lhs.dataConverted {
            $0 / rhs
        }
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        return rhs.dataConverted {
            lhs / $0
        }
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        for i in 0..<lhs.data.count {
            lhs.data[i] /= rhs
        }
    }
    
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        return lhs.dataConverted {
            $0 / rhs
        }
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        return rhs.dataConverted {
            lhs / $0
        }
    }
}
