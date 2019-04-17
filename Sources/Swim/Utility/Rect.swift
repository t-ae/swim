public struct Rect {
    public var x: Int
    public var y: Int
    public var width: Int
    public var height: Int
    
    @inlinable
    public init(x: Int, y: Int, width: Int, height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

extension Rect: Equatable {
    @inlinable
    public static func ==(lhs: Rect, rhs: Rect) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.width == rhs.width && lhs.height == rhs.height
    }
}

extension Rect: Hashable {
}
