extension Image {
    /// Create new image which is filled with `value` and size/type is like `image`.
    @inlinable
    public static func full(value: T, like image: Image<P, T>) -> Image {
        return Image(width: image.width, height: image.height, value: value)
    }
    
    /// Create new image which is filled with `value` and size is like `image`.
    @inlinable
    public static func full<P2, T2>(value: T, like image: Image<P2, T2>) -> Image {
        return Image(width: image.width, height: image.height, value: value)
    }
}

extension Image where T: AdditiveArithmetic {
    /// Create new image which is filled with 0 and size/type is like `image`.
    @inlinable
    public static func zeros(like image: Image<P, T>) -> Image<P, T> {
        return full(value: T.zero, like: image)
    }
    
    /// Create new image which is filled with 0 and size is like `image`.
    @inlinable
    public static func zeros<P2, T2>(like image: Image<P2, T2>) -> Image<P, T> {
        return full(value: T.zero, like: image)
    }
}

extension Image where T: ExpressibleByIntegerLiteral {
    /// Create new image which is filled with 1 and size/type is like `image`.
    @inlinable
    public static func ones(like image: Image<P, T>) -> Image<P, T> {
        return full(value: 1, like: image)
    }
    
    /// Create new image which is filled with 1 and size is like `image`.
    @inlinable
    public static func ones<P2, T2>(like image: Image<P2, T2>) -> Image<P, T> {
        return full(value: 1, like: image)
    }
}
