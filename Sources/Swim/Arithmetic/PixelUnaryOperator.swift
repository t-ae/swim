extension PixelProtocol where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Self) -> Pixel<P, T> {
        return Pixel<P, T>(data: arg.withUnsafeBufferPointer { $0.map { -$0 } })
    }
}
