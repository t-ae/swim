
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
        for (l, r) in zip(lhs.data, rhs.data) {
            if l != r {
                return false
            }
        }
        return true
    }
}

extension Image {
    func index(x: Int, y: Int) -> Int {
        assert(0 <= x && x < width)
        assert(0 <= y && y < height)
        
        return ((y * width) + x) * P.channels
    }
}
