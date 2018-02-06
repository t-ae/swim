
extension Image {
    func getPixel(x: Int, y: Int, c: Int = 0) -> T {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        precondition(0 <= c && c < P.channels, "Index out of range.")
        
        return self[unsafe: x, y, c]
    }
    
    mutating func setPixel(x: Int, y: Int, c: Int = 0, newValue: T) {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        precondition(0 <= c && c < P.channels, "Index out of range.")
        
        self[unsafe: x, y, c] = newValue
    }
    
    func getPixel(x: Int, y: Int) -> Pixel<P, T> {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        
        return self[unsafe: x, y]
    }
    
    mutating func setPixel(x: Int, y: Int, newValue: Pixel<P, T>) {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        
        self[unsafe: x, y] = newValue
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

// MARK: - internal
extension Image {
    subscript(unsafe x: Int, y: Int) -> Pixel<P, T> {
        get {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            
            let start = index(x: x, y: y)
            return Pixel(data: [T](data[start..<start+P.channels]))
        }
        set {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            
            let start = index(x: x, y: y)
            data.replaceSubrange(start..<start+P.channels, with: newValue.data)
        }
    }
    
    subscript(unsafe x: Int, y: Int, c: Int) -> T {
        get {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            assert(0 <= c && c < P.channels, "Index out of range.")
            
            return data[index(x: x, y: y, c: c)]
        }
        set {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            assert(0 <= c && c < P.channels, "Index out of range.")
            
            data[index(x: x, y: y, c: c)] = newValue
        }
    }
    
    subscript(unsafe x: Int, y: Int, c: P) -> T {
        get {
            return data[index(x: x, y: y, c: c.rawValue)]
        }
        set {
            data[index(x: x, y: y, c: c.rawValue)] = newValue
        }
    }
}
