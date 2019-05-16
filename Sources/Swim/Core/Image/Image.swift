import Foundation

public struct Image<P: PixelType, T: DataType> {
    public let width: Int
    public let height: Int
    
    @usableFromInline
    var data: [T]

    @inlinable
    public init(width: Int, height: Int, data: [T]) {
        precondition(width >= 0 && height >= 0, "Image can't have negative size.")
        precondition(data.count == width * height * P.channels,
                     "Size of `data` must be equal to `width` * `height` * number of channels")
        self.width = width
        self.height = height
        self.data = data
    }
    
    @inlinable
    public init(width: Int, height: Int, value: T) {
        let data = [T](repeating: value, count: width*height*P.channels)
        self.init(width: width, height: height, data: data)
    }
    
    @inlinable
    public init(width: Int, height: Int, pixel: Pixel<P, T>) {
        var data = [T](repeating: T.swimDefaultValue, count: width*height*P.channels)
        
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<width*height {
                memcpy(dst, pixel.data, P.channels*MemoryLayout<T>.size)
                dst += P.channels
            }
        }
        
        self.init(width: width, height: height, data: data)
    }
    
    @inlinable
    init(width: Int, height: Int) {
        self.init(width: width, height: height, value: T.swimDefaultValue)
    }
}

extension Image {
    @inlinable
    public var size: (width: Int, height: Int) {
        return (width, height)
    }
    
    @inlinable
    public var pixelCount: Int {
        return width * height
    }
}

extension Image: Equatable where T: Equatable {
    @inlinable
    public static func ==(lhs: Image, rhs: Image) -> Bool {
        guard lhs.size == rhs.size else {
            return false
        }
        return lhs.data == rhs.data
    }
}

extension Image {
    /// Get the index of specified pixel/channel in buffer.
    @inlinable
    public func dataIndex(x: Int, y: Int, c: Int = 0) -> Int {
        precondition(0 <= x && x < width, "Index out of range.")
        precondition(0 <= y && y < height, "Index out of range.")
        precondition(0 <= c && c < P.channels, "Index out of range.")
        
        return (y * width + x) * P.channels + c
    }
}
