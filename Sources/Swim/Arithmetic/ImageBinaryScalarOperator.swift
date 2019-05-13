// MARK: - Image
extension Image where T: AdditiveArithmetic {
    @inlinable
    public static func +(lhs: Image, rhs: T) -> Image {
        var newImage = lhs
        newImage += rhs
        return newImage
    }
    
    @inlinable
    public static func +(lhs: T, rhs: Image) -> Image {
        var newImage = rhs
        newImage += lhs
        return newImage
    }
    
    @inlinable
    public static func -(lhs: Image, rhs: T) -> Image {
        var newImage = lhs
        newImage -= rhs
        return newImage
    }
    
    @inlinable
    public static func -(lhs: T, rhs: Image) -> Image {
        var newImage = rhs
        
        for i in 0..<newImage.data.count {
            newImage.data[i] = lhs - newImage.data[i]
        }
        
        return newImage
    }
}

extension Image where T: Numeric {
    @inlinable
    public static func *(lhs: Image, rhs: T) -> Image {
        var newImage = lhs
        newImage *= rhs
        return newImage
    }
    
    @inlinable
    public static func *(lhs: T, rhs: Image) -> Image {
        var newImage = rhs
        newImage *= lhs
        return newImage
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var newImage = lhs
        newImage /= rhs
        return newImage
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var newImage = rhs
        
        for i in 0..<newImage.data.count {
            newImage.data[i] = lhs / newImage.data[i]
        }
        
        return newImage
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public static func /(lhs: Image, rhs: T) -> Image {
        var newImage = lhs
        newImage /= rhs
        return newImage
    }
    
    @inlinable
    public static func /(lhs: T, rhs: Image) -> Image {
        var newImage = rhs
        
        for i in 0..<newImage.data.count {
            newImage.data[i] = lhs / newImage.data[i]
        }
        
        return newImage
    }
}
