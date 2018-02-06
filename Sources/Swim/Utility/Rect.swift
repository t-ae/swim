
public struct Rect {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
}

extension Rect: Equatable {
    public static func ==(lhs: Rect, rhs: Rect) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.width == rhs.width && lhs.height == rhs.height
    }
}

extension Rect: Hashable {
    public var hashValue: Int {
        var hash = x.hashValue
        hash = hash &* 31 &+ y.hashValue
        hash = hash &* 31 &+ width.hashValue
        hash = hash &* 31 &+ height.hashValue
        return hash
    }
}
