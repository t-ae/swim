

extension Image where PT == Intensity, DT == UInt8 {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == Intensity, DT == Int {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == Intensity, DT == Float {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == Intensity, DT == Double {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == UInt8 {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == Int {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == Float {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == IntensityAlpha, DT == Double {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == UInt8 {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == Int {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == Float {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGB, DT == Double {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == UInt8 {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == Int {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == Float {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == RGBA, DT == Double {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == UInt8 {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == Int {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == Float {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where PT == ARGB, DT == Double {
    public static func +(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Image, rhs: Image) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Image, rhs: Image) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Image, rhs: Image) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Image, rhs: Image) -> Image {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Image, rhs: Image) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}


extension Pixel where PT == Intensity, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == Intensity, DT == Int {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == Intensity, DT == Float {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == Intensity, DT == Double {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == Int {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == Float {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == IntensityAlpha, DT == Double {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == Int {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == Float {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGB, DT == Double {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == Int {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == Float {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == RGBA, DT == Double {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == UInt8 {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == Int {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == Float {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Pixel where PT == ARGB, DT == Double {
    public static func +(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret += rhs
        return ret
    }
    
    public static func +=(lhs: inout Pixel, rhs: Pixel) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func -(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret -= rhs
        return ret
    }

    public static func -=(lhs: inout Pixel, rhs: Pixel) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func *(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret *= rhs
        return ret
    }
    
    public static func *=(lhs: inout Pixel, rhs: Pixel) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    public static func /(lhs: Pixel, rhs: Pixel) -> Pixel {
        var ret = lhs
        ret /= rhs
        return ret
    }
    
    public static func /=(lhs: inout Pixel, rhs: Pixel) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

