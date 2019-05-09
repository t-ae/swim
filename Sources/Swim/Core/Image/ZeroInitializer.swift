extension Image where T: AdditiveArithmetic {
    public static func zerosLike(image: Image<P, T>) -> Image<P, T> {
        return Image(width: image.width, height: image.height, value: .zero)
    }
}
