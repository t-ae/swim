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
        return image.dataConverted(!)
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
        precondition(lhs.size == rhs.size, "Images must have same size.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] && rhs.data[i]
            }
        }
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
        precondition(lhs.size == rhs.size, "Images must have same size.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] || rhs.data[i]
            }
        }
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
        precondition(lhs.size == rhs.size, "Images must have same size.")
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) { bp in
            for i in 0..<bp.count {
                bp[i] = lhs.data[i] != rhs.data[i]
            }
        }
    }
}
