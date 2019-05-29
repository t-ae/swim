extension Image where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        return arg.dataConverted(-)
    }
    
    @inlinable
    public static prefix func +(arg: Image) -> Image {
        return arg
    }
}
