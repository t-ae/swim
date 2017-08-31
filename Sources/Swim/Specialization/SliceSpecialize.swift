
// FIXME: Wait for Swift4
/*
extension Image where P == Intensity, T == UInt8 {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == Intensity, T == Int {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == Intensity, T == Float {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == Intensity, T == Double {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGB, T == UInt8 {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGB, T == Int {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGB, T == Float {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGB, T == Double {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGBA, T == UInt8 {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGBA, T == Int {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGBA, T == Float {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == RGBA, T == Double {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == ARGB, T == UInt8 {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == ARGB, T == Int {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == ARGB, T == Float {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

extension Image where P == ARGB, T == Double {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> Image<P, T> {
        get {
            return getSubimage(xRange: xRange, yRange: yRange)
        }
        set {
            setSubimage(xRange: xRange, yRange: yRange, newValue: newValue)
        }
    }
    
    public subscript(rows rows: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[0..<width, rows]
        }
        set {
            self[0..<width, rows] = newValue
        }
    }
    
    public subscript(cols cols: CountableRange<Int>) -> Image<P, T> {
        get {
            return self[cols, 0..<height]
        }
        set {
            self[cols, 0..<height] = newValue
        }
    }
}

*/
