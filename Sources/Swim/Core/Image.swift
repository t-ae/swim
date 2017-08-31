
public struct Image<P: PixelType, T: DataType> {
    public let width: Int
    public let height: Int
    public internal(set) var data: [T]
    
    public init(width: Int, height: Int, data: [T]) {
        precondition(data.count == width * height * P.channels)
        self.width = width
        self.height = height
        self.data = data
    }
}

extension Image: Equatable {
    public static func == (lhs: Image, rhs: Image) -> Bool {
        guard lhs.width == rhs.width && lhs.height == rhs.height else {
            return false
        }
        for (l, r) in zip(lhs.data, rhs.data) {
            if l != r {
                return false
            }
        }
        return true
    }
}

extension Image {
    func index(x: Int, y: Int, c: Int = 0) -> Int {
        precondition(0 <= x && x < width)
        precondition(0 <= y && y < height)
        precondition(0 <= c && c < P.channels)
        
        return ((y * width) + x) * P.channels + c
    }
}
