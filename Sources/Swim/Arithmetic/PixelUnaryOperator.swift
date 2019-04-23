extension PixelProtocol where T: SignedNumeric {
    @inlinable
    static func negate(arg: Self) -> Pixel<P, T> {
        var ret = Pixel<P, T>.zero
        ret -= arg
        return ret
    }
    
    @inlinable
    public static prefix func -(arg: Self) -> Pixel<P, T> {
        return negate(arg: arg)
    }
}
