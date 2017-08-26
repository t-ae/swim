extension Image where P == Intensity {
    public subscript(x: Int, y: Int) -> T {
        get {
            precondition(0 <= x && x < width)
            precondition(0 <= y && y < height)
            return data[y * width + x]
        }
        set {
            precondition(0 <= x && x < width)
            precondition(0 <= y && y < height)
            data[y * width + x] = newValue
        }
    }
}

extension Image {
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            precondition(0 <= c && c < P.channels)
            return data[(y * width + x) * P.channels + c]
        }
        set {
            precondition(0 <= c && c < P.channels)
            data[(y * width + x) * P.channels + c] = newValue
        }
    }
    
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            let start = (y * width + x) * P.channels
            return Pixel(data: [T](data[start..<start+P.channels]))
        }
        set {
            let start = (y * width + x) * P.channels
            self.data.replaceSubrange(start..<start+P.channels, with: newValue.data)
        }
    }
}
