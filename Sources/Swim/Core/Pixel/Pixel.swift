public struct Pixel<P: PixelType, T: DataType> {
    public let x: Int
    public let y: Int
    
    public let color: Color<P, T>
    
    @inlinable
    public init(x: Int, y: Int, color: Color<P, T>) {
        self.x = x
        self.y = y
        self.color = color
    }
    
    @inlinable
    init(x: Int, y: Int, data: ArraySlice<T>) {
        self.init(x: x, y: y, color: Color(data: data))
    }
}

extension Pixel {
    @inlinable
    public subscript(c: Int) -> T {
        get {
            return color[c]
        }
    }
    
    @inlinable
    public subscript(c: P) -> T {
        get {
            return color[c]
        }
    }
}

extension Pixel: Equatable where T: Equatable {}
