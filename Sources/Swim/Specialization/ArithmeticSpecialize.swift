
extension Image where P == Intensity, T == UInt8 {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == Intensity, T == Int {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == Intensity, T == Float {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == Intensity, T == Double {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGB, T == UInt8 {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGB, T == Int {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGB, T == Float {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGB, T == Double {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGBA, T == UInt8 {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGBA, T == Int {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGBA, T == Float {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == RGBA, T == Double {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == ARGB, T == UInt8 {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == ARGB, T == Int {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == ARGB, T == Float {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

extension Image where P == ARGB, T == Double {
    public static func +(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image<P, T>, rhs: T) {
        add(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret -= rhs
        return ret
    }
    
    public static func -=(lhs: inout Image<P, T>, rhs: T) {
        subtract(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image<P, T>, rhs: T) {
        multiply(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image<P, T>, rhs: T) -> Image<P, T> {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image<P, T>, rhs: T) {
        divide(lhs: &lhs, rhs: rhs)
    }
}

