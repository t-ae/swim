import Foundation

extension Image {
    @inlinable
    public subscript(x: Int, y: Int, c: Int) -> T {
        get {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            precondition(0 <= c && c < P.channels, "Index out of range.")
            
            return data[dataIndex(x: x, y: y, c: c)]
        }
        set {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            precondition(0 <= c && c < P.channels, "Index out of range.")
            
            data[dataIndex(x: x, y: y, c: c)] = newValue
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
    public subscript(x: Int, y: Int) -> Color<P, T> {
        get {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            
            let start = dataIndex(x: x, y: y)
            return Color(data: data[start..<start+P.channels])
        }
        set {
            precondition(0 <= x && x < width, "Index out of range.")
            precondition(0 <= y && y < height, "Index out of range.")
            
            let start = dataIndex(x: x, y: y)
            data[start..<start+P.channels] = newValue.data
        }
    }
}
