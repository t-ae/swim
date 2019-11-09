extension Image where T == Bool {
    // MARK: - Negation
    @inlinable
    public mutating func negate() {
        dataMutate {
            $0.toggle()
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
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) {
            var p = $0.baseAddress!
            for i in 0..<$0.count {
                p.initialize(to: lhs.data[i] && rhs.data[i])
                p += 1
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
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) {
            var p = $0.baseAddress!
            for i in 0..<$0.count {
                p.initialize(to: lhs.data[i] || rhs.data[i])
                p += 1
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
        
        return .createWithUnsafeMutableBufferPointer(width: lhs.width, height: lhs.height) {
            var p = $0.baseAddress!
            for i in 0..<$0.count {
                p.initialize(to: lhs.data[i] != rhs.data[i])
                p += 1
            }
        }
    }
}
