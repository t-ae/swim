
import Foundation

public struct ImageSlice<P: PixelType, T: DataType> {
    
    let image: Image<P, T>
    public let x: Int
    public let y: Int
    public let width: Int
    public let height: Int
    
    init(image: Image<P, T>, x: Int, y: Int, width: Int, height: Int) {
        assert(x >= 0 && y >= 0 && width >= 0 && height >= 0)
        assert(x+width <= image.width)
        assert(y+height <= image.height)
        
        self.image = image
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

extension Image {
    public init(_ slice: ImageSlice<P, T>) {
        var data = [T](repeating: 0, count: slice.width*slice.height*P.channels)
        
        slice.image.data.withUnsafeBufferPointer {
            var src = $0.baseAddress! + ((slice.y * slice.image.width) + slice.x) * P.channels
            data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<slice.height {
                    memcpy(dst, src, slice.width * P.channels * MemoryLayout<T>.size)
                    src += slice.image.width * P.channels
                    dst += slice.width * P.channels
                }
            }
        }
        
        self.init(width: slice.width, height: slice.height, data: data)
    }
}
