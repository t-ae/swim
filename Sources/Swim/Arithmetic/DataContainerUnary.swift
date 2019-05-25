extension DataContainer where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Self) -> Self {
        var new = arg
        
        new.withUnsafeMutableBufferPointer { bp in
            for i in 0..<bp.count {
                bp[i].negate()
            }
        }
        
        return new
    }
    
    @inlinable
    public static prefix func +(arg: Self) -> Self {
        return arg
    }
}
