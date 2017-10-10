
import Foundation

public struct Image<P: PixelType, T: DataType> {
    public let width: Int
    public let height: Int
    var _data: [T]
    
    public var data: [T] {
        get {
            return _data
        }
        set {
            precondition(data.count == width * height * P.channels,
                         "Size of `data` must be exaclty `width` * `height` * number of channels")
            _data = newValue
        }
    }
    
    public init(width: Int, height: Int, data: [T]) {
        precondition(width >= 0 && height >= 0, "Image can't have negative size.")
        precondition(data.count == width * height * P.channels, "Size of `data` must be exaclty `width` * `height` * number of channels")
        self.width = width
        self.height = height
        self._data = data
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
    public var size: (width: Int, height: Int) {
        return (width, height)
    }
    
    public var pixelCount: Int {
        return width * height
    }
}

extension Image: Equatable {
    public static func ==(lhs: Image, rhs: Image) -> Bool {
        guard lhs.size == rhs.size else {
            return false
        }
        return memcmp(lhs._data, rhs._data, lhs.width*lhs.height*P.channels*MemoryLayout<T>.size) == 0
    }
}

extension Image {
    func index(x: Int, y: Int, c: Int = 0) -> Int {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        precondition(0 <= c && c < P.channels, "Index out of range.")
        
        return ((y * width) + x) * P.channels + c
    }
}
