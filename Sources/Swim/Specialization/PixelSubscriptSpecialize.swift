
extension Image where P == Intensity, T == UInt8 {
    public subscript(x: Int, y: Int) -> T {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Int {
    public subscript(x: Int, y: Int) -> T {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Float {
    public subscript(x: Int, y: Int) -> T {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Double {
    public subscript(x: Int, y: Int) -> T {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == UInt8 {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Int {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Float {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Double {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return self.getPixel(x: x, y: y, c: c)
        }
        set {
            self.setPixel(x: x, y: y, c: c, newValue: newValue)
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            return self.getPixel(x: x, y: y)
        }
        set {
            self.setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

