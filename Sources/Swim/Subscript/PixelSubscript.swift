import Foundation

extension Image where P == Intensity {
    @inlinable
    public subscript(x: Int, y: Int) -> T {
        get {
            return self[x, y, 0]
        }
        set {
            self[x, y, 0] = newValue
        }
    }
}

extension Image {
    @inlinable
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            precondition(0 <= c && c < P.channels, "Index out of range.")
            
            return self[unsafe: x, y, c]
        }
        set {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            precondition(0 <= c && c < P.channels, "Index out of range.")
            
            self[unsafe: x, y, c] = newValue
        }
    }
    
    @inlinable
    public subscript(x: Int, y: Int, c: P) -> T {
        get {
            return self[x, y, c.rawValue]
        }
        set {
            self[x, y, c.rawValue] = newValue
        }
    }
    
    @inlinable
    public subscript(x: Int, y: Int) -> Pixel<P, T> {
        get {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            
            return self[unsafe: x, y]
        }
        set {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            
            self[unsafe: x, y] = newValue
        }
    }
}

// MARK: - internal
extension Image {
    @inlinable
    subscript(unsafe x: Int, y: Int) -> Pixel<P, T> {
        get {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            
            let start = dataIndex(x: x, y: y)
            return Pixel(data: [T](data[start..<start+P.channels]))
        }
        set {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            
            let start = dataIndex(x: x, y: y)
            data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress! + start
                memcpy(dst, newValue.data, MemoryLayout<T>.size * P.channels)
            }
        }
    }
    
    @inlinable
    subscript(unsafe x: Int, y: Int, c: Int) -> T {
        get {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            assert(0 <= c && c < P.channels, "Index out of range.")
            
            return data[dataIndex(x: x, y: y, c: c)]
        }
        set {
            assert(0 <= x && x < width, "Index out of range.")
            assert(0 <= y && y < height, "Index out of range.")
            assert(0 <= c && c < P.channels, "Index out of range.")
            
            data[dataIndex(x: x, y: y, c: c)] = newValue
        }
    }
    
    @inlinable
    subscript(unsafe x: Int, y: Int, c: P) -> T {
        get {
            return data[dataIndex(x: x, y: y, c: c.rawValue)]
        }
        set {
            data[dataIndex(x: x, y: y, c: c.rawValue)] = newValue
        }
    }
}
