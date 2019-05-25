
extension Image {
    /// Convert all pixel values.
    @inlinable
    public mutating func dataConvert(_ body: (T)->T) {
        for i in 0..<data.count {
            data[i] = body(data[i])
        }
    }
    
    /// Convert all pixel values.
    @inlinable
    public func dataConverted<T2>(_ body: (T) -> T2) -> Image<P, T2> {
        var newImage = Image<P, T2>(width: width, height: height)
        
        for i in 0..<data.count {
            newImage.data[i] = body(data[i])
        }
        
        return newImage
    }
}
