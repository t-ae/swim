extension Image where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        var new = arg
        
        for i in 0..<new.data.count {
            new.data[i].negate()
        }
        
        return new
    }
    
    @inlinable
    public static prefix func +(arg: Image) -> Image {
        return arg
    }
}
