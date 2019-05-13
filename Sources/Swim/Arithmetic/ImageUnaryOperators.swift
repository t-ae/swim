extension Image where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        var newImage = arg
        
        for i in 0..<newImage.data.count {
            newImage.data[i].negate()
        }
        
        return newImage
    }
    
    @inlinable
    public static prefix func +(arg: Image) -> Image {
        return arg
    }
}
