extension Image {
    public static func full(value: T, like image: Image<P, T>) -> Image {
        return Image(width: image.width, height: image.height, value: value)
    }
    
    public static func full<P2, T2>(value: T, like image: Image<P2, T2>) -> Image {
        return Image(width: image.width, height: image.height, value: value)
    }
}

extension Image where T: ExpressibleByIntegerLiteral {
    public static func zeros(like image: Image<P, T>) -> Image<P, T> {
        return full(value: 0, like: image)
    }
    
    public static func ones(like image: Image<P, T>) -> Image<P, T> {
        return full(value: 1, like: image)
    }
    
    public static func zeros<P2, T2>(like image: Image<P2, T2>) -> Image<P, T> {
        return full(value: 0, like: image)
    }
    
    public static func ones<P2, T2>(like image: Image<P2, T2>) -> Image<P, T> {
        return full(value: 1, like: image)
    }
}
