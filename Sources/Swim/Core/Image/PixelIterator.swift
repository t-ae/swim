public struct PixelIterator<P: PixelType, T: DataType>: IteratorProtocol, Sequence {
    
    @usableFromInline let image: Image<P, T>
    
    @usableFromInline var x: Int = 0
    @usableFromInline var y: Int = 0
    @usableFromInline var start = 0
    
    public init(image: Image<P, T>) {
        self.image = image
    }
    
    @inlinable
    public mutating func next() -> Pixel<P, T>? {
        defer {
            x += 1
            if x >= image.width {
                y += 1
                x = 0
            }
            start += P.channels
        }
        
        guard y < image.height else {
            return nil
        }
        
        return Pixel(data: image.data[start..<start+P.channels])
    }
}

extension Image {
    public func pixels() -> PixelIterator<P, T> {
        return PixelIterator(image: self)
    }
}
