extension Color where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Color) -> Color {
        return .createWithUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i] = -arg[i]
            }
        }
    }
    
    @inlinable
    public static prefix func +(arg: Color) -> Color {
        return arg
    }
}
