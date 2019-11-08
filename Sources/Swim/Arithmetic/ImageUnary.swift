extension Image where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        return arg.dataConverted(-)
    }
    
    @inlinable
    public mutating func negate() {
        dataMutate { e in
            e.negate()
        }
    }
    
    @inlinable
    public static prefix func +(arg: Image) -> Image {
        return arg
    }
}
