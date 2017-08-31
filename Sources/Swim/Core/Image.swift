
import Foundation

public struct Image<P: PixelType, T: DataType> {
    public let width: Int
    public let height: Int
    public var data: [T]
    
    public init(width: Int, height: Int, data: [T]) {
        precondition(data.count == width * height * P.channels)
        self.width = width
        self.height = height
        self.data = data
    }
    
    public init(width: Int, height: Int, value: T) {
        let data = [T](repeating: value, count: width*height*P.channels)
        self.init(width: width, height: height, data: data)
    }
    
    init(width: Int, height: Int) {
        let data = [T](repeating: T.swimDefaultValue, count: width*height*P.channels)
        self.init(width: width, height: height, data: data)
    }
}

extension Image: Equatable {
    public static func == (lhs: Image, rhs: Image) -> Bool {
        guard lhs.width == rhs.width && lhs.height == rhs.height else {
            return false
        }
        return memcmp(lhs.data, rhs.data, lhs.width*lhs.height*P.channels*MemoryLayout<T>.size) == 0
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
