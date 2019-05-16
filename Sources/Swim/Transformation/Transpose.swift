extension Image {
    @inlinable
    public func transpose() -> Image<P, T> {
        var newImage = Image<P, T>(width: height, height: width)
        
        newImage.pixelwiseConvert { ref in
            ref.assign(x: ref.y, y: ref.x, in: self)
        }
        
        return newImage
    }
}
