
extension Image {
    func getPixel(x: Int, y: Int, c: Int = 0) -> T {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        precondition(0 <= c && c < P.channels, "Index out of range.")
        
        return _data[index(x: x, y: y, c: c)]
    }
    
    mutating func setPixel(x: Int, y: Int, c: Int = 0, newValue: T) {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        precondition(0 <= c && c < P.channels, "Index out of range.")
        
        _data[index(x: x, y: y, c: c)] = newValue
    }
    
    func getPixel(x: Int, y: Int) -> Pixel<P, T> {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        
        let start = index(x: x, y: y)
        return Pixel(data: [T](_data[start..<start+P.channels]))
    }
    
    mutating func setPixel(x: Int, y: Int, newValue: Pixel<P, T>) {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        
        let start = index(x: x, y: y)
        _data.replaceSubrange(start..<start+P.channels, with: newValue._data)
    }
}

extension Image where P == Intensity {
    public subscript(x: Int, y: Int) -> T {
        get {
            return getPixel(x: x, y: y)
        }
        set {
            setPixel(x: x, y: y, newValue: newValue)
        }
    }
}

extension Image {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return getPixel(x: x, y: y, c: c)
        }
        set {
            setPixel(x: x, y: y, c: c, newValue: newValue)
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
