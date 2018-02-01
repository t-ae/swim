
extension Image where P == Intensity, T == Bool {
    public subscript(x: Int, y: Int) -> T {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == UInt8 {
    public subscript(x: Int, y: Int) -> T {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Int {
    public subscript(x: Int, y: Int) -> T {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Float {
    public subscript(x: Int, y: Int) -> T {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Double {
    public subscript(x: Int, y: Int) -> T {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Bool {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Bool {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Bool {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Bool {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Bool {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }

    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return getPixel(x: x, y: y, c: c.rawValue)
        }
        set {
            setPixel(x: x, y: y, c: c.rawValue, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

