extension Color where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<P.channels {
                bp[i] = -arg[i]
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
