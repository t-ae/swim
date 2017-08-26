
import Foundation

public protocol PixelSequence: Sequence {
    
    associatedtype PT: PixelType
    associatedtype DT: DataType
    
    var width: Int { get }
    var height: Int { get }
}

extension Image: PixelSequence {
    public typealias PT = P
    public typealias DT = T
    
    public func makeIterator() -> PixelIterator<P, T> {
        return PixelIterator(image: self)
    }
}

extension ImageSlice: PixelSequence {
    public typealias PT = P
    public typealias DT = T
    
    public func makeIterator() -> PixelIterator<P, T> {
        return PixelIterator(image: image, x: x, y: y, width: width, height: height)
    }
}

public struct PixelIterator<P: PixelType, T: DataType>: IteratorProtocol {
    let image: Image<P, T>
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    
    var dx: Int = 0
    var dy: Int = 0
    var pixel: Pixel<P, T>
    
    init(image: Image<P, T>, x: Int, y: Int, width: Int, height: Int) {
        assert(x >= 0 && y >= 0 && width >= 0 && height >= 0)
        assert(x+width < image.width)
        assert(y+height < image.height)
        self.image = image
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.dx = 0
        self.dy = 0
        self.pixel = Pixel<P, T>(data: [T](repeating: 0, count: P.channels))
    }
    
    init(image: Image<P, T>) {
        self.init(image: image, x: 0, y: 0, width: image.width, height: image.height)
    }
    
    public mutating func next() -> (x: Int, y: Int, pixel: Pixel<P, T>)? {
        guard dy < height else {
            return nil
        }
        
        let _dx = dx
        let _dy = dy
        
        dx += 1
        if dx >= width {
            dx = 0
            dy += 1
        }
        
        let start = image.index(x: x + _dx, y: y + _dy)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress! + start
            pixel.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                memcpy(dst, src, P.channels * MemoryLayout<T>.size)
            }
        }
        
        return (_dx, _dy, pixel)
    }
}
