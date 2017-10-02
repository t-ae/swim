

extension Image where PT ==Intensity, DT == Int {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==Intensity, DT == Float {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==Intensity, DT == Double {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==IntensityAlpha, DT == Int {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==IntensityAlpha, DT == Float {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==IntensityAlpha, DT == Double {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==RGB, DT == Int {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==RGB, DT == Float {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==RGB, DT == Double {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==RGBA, DT == Int {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==RGBA, DT == Float {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==RGBA, DT == Double {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==ARGB, DT == Int {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==ARGB, DT == Float {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}

extension Image where PT ==ARGB, DT == Double {
    public static prefix func -(arg: Image) -> Image {
        return negate(arg: arg)
    }
}


extension Image where PT == Intensity, DT == UInt8 {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == Intensity, DT == Int {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == Intensity, DT == Float {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == Intensity, DT == Double {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == UInt8 {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == Int {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == Float {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == Double {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == UInt8 {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == Int {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == Float {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == Double {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == UInt8 {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == Int {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == Float {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == Double {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == UInt8 {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == Int {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == Float {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == Double {
    public static func +(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Image) -> Image {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Image, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Image) -> Image {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: DT) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Image) -> Image {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Image, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}


extension Pixel where PT ==Intensity, DT == Int {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==Intensity, DT == Float {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==Intensity, DT == Double {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==IntensityAlpha, DT == Int {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==IntensityAlpha, DT == Float {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==IntensityAlpha, DT == Double {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==RGB, DT == Int {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==RGB, DT == Float {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==RGB, DT == Double {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==RGBA, DT == Int {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==RGBA, DT == Float {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==RGBA, DT == Double {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==ARGB, DT == Int {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==ARGB, DT == Float {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}

extension Pixel where PT ==ARGB, DT == Double {
    public static prefix func -(arg: Pixel) -> Pixel {
        return negate(arg: arg)
    }
}


extension Pixel where PT == Intensity, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == Intensity, DT == Int {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == Intensity, DT == Float {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == Intensity, DT == Double {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == Int {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == Float {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == Double {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == Int {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == Float {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == Double {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == Int {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == Float {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == Double {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == Int {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == Float {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == Double {
    public static func +(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }

    public static func +(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret += lhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: DT) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -(lhs: DT, rhs: Pixel) -> Pixel {
        return subtract(lhs: lhs, rhs: rhs)
    }
    
    public static func -=(lhs: inout Pixel, rhs: DT) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }

    public static func *(lhs: DT, rhs: Pixel) -> Pixel {
        var ret = rhs
        ret *= lhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: DT) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: DT) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }

    public static func /(lhs: DT, rhs: Pixel) -> Pixel {
        return divide(lhs: lhs, rhs: rhs)
    }
    
    public static func /=(lhs: inout Pixel, rhs: DT) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

