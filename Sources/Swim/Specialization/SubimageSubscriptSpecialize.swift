
// FIXME: Wait for Swift4
/*
extension Image where P == Intensity, T == Bool {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Bool {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == UInt8 {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Int {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Float {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == IntensityAlpha, T == Double {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Bool {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Bool {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Bool {
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
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

    public subscript(row row: Int) -> Image<P, T> {
        get {
            return getSubimage(x: 0, y: row, width: width, height: 1)
        }
        set {
            setSubimage(x: 0, y: row, width: width, height: 1, newValue: newValue)
        }
    }
    
    public subscript(col col: Int) -> Image<P, T> {
        get {
            return getSubimage(x: col, y: 0, width: 1, height: height)
        }
        set {
            setSubimage(x: col, y: 0, width: 1, height: height, newValue: newValue)
        }
    }
}

*/
