extension Image where T: SignedNumeric {
    @inlinable
    public static prefix func -(arg: Image) -> Image {
        var ret = arg
        ret.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee.negate()
                p += 1
            }
        }
        return ret
    }
    
    @inlinable
    public static prefix func +(arg: Image) -> Image {
        return arg
    }
}
