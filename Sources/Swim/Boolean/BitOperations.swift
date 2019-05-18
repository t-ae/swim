extension Image where T == Bool {
    // MARK: - Negation
    @inlinable
    public mutating func negate() {
        for i in 0..<self.data.count {
            self.data[i].toggle()
        }
    }
    
    @inlinable
    public static prefix func ~(image: Image) -> Image {
        var newImage = image
        newImage.negate()
        return newImage
    }
    
    // MARK: - And
    @inlinable
    public static func &=(lhs: inout Image, rhs: Image) {
        precondition(lhs.size == rhs.size, "Images must have same size.")
        for i in 0..<lhs.data.count {
            lhs.data[i] = lhs.data[i] && rhs.data[i]
        }
    }
    
    @inlinable
    public static func &(lhs: Image, rhs: Image) -> Image {
        var newImage = lhs
        newImage &= rhs
        return newImage
    }
    
    // MARK: - Or
    @inlinable
    public static func |=(lhs: inout Image, rhs: Image) {
        precondition(lhs.size == rhs.size, "Images must have same size.")
        for i in 0..<lhs.data.count {
            lhs.data[i] = lhs.data[i] || rhs.data[i]
        }
    }
    
    @inlinable
    public static func |(lhs: Image, rhs: Image) -> Image {
        var newImage = lhs
        newImage |= rhs
        return newImage
    }
    
    // MARK: - Xor
    @inlinable
    public static func ^=(lhs: inout Image, rhs: Image) {
        precondition(lhs.size == rhs.size, "Images must have same size.")
        for i in 0..<lhs.data.count {
            lhs.data[i] = lhs.data[i] != rhs.data[i]
        }
    }
    
    @inlinable
    public static func ^(lhs: Image, rhs: Image) -> Image {
        var newImage = lhs
        newImage ^= rhs
        return newImage
    }
}
