extension PixelProtocol where T: SignedNumeric {
    @inlinable
    static func negate(arg: Self) -> Pixel<P, T> {
        return 0 - arg
    }
    
    @inlinable
    public static prefix func -(arg: Self) -> Pixel<P, T> {
        return negate(arg: arg)
    }
}
