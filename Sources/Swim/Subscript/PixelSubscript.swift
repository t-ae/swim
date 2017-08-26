extension Image where P == Intensity {
    public subscript(x: Int, y: Int) -> T {
        get {
            return data[index(x: x, y: y)]
        }
        set {
            data[index(x: x, y: y)] = newValue
        }
    }
}

extension Image {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            return data[index(x: x, y: y, c: c)]
        }
        set {
            data[index(x: x, y: y, c: c)] = newValue
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            let start = index(x: x, y: y)
            return Pixel(data: [T](data[start..<start+P.channels]))
        }
        set {
            let start = index(x: x, y: y)
            self.data.replaceSubrange(start..<start+P.channels, with: newValue.data)
        }
    }
}
