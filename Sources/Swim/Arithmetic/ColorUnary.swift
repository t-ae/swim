extension Color where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for i in 0..<P.channels {
                p.initialize(to: -arg[i])
                p += 1
            }
        }
    }
    
    @inlinable
    public mutating func negate() {
        for i in 0..<P.channels {
            data[i].negate()
        }
    }
    
    @inlinable
    public static prefix func +(arg: Color) -> Color {
        return arg
    }
}
