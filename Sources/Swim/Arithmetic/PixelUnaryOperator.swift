extension PixelProtocol where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Self) -> Pixel<P, T> {
        return 0 - arg
    }
}
