
import Foundation

public struct Image<P: PixelType, T: DataType> {
    public let width: Int
    public let height: Int
    public var data: [T]
    
    public init(width: Int, height: Int, data: [T]) {
        precondition(width >= 0 && height >= 0)
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
        self.init(width: width, height: height, value: T.swimDefaultValue)
    }
}

extension Image {
    var size: (width: Int, height: Int) {
        return (width, height)
    }
    
    var pixelCount: Int {
        return width * height
    }
}

extension Image: Equatable {
    public static func ==(lhs: Image, rhs: Image) -> Bool {
        guard lhs.size == rhs.size else {
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
