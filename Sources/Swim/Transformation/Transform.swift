public struct Transform<P: PixelType, T: DataType> {
    @usableFromInline
    let image: Image<P, T>
    
    public init(image: Image<P, T>) {
        self.image = image
    }
}

extension Image {
    public var transform: Transform<P, T> {
        return Transform(image: self)
    }
}
