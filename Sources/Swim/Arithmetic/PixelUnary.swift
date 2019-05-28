extension Color where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Color) -> Color {
        var new = arg
        
        for i in 0..<new.data.count {
            new.data[i].negate()
        }
        
        return new
    }
    
    @inlinable
    public static prefix func +(arg: Color) -> Color {
        return arg
    }
}
