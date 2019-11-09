extension Image {
    /// Convert all pixel values.
    @inlinable
    public mutating func dataConvert(_ body: (T)->T) {
        for i in 0..<data.count {
            data[i] = body(data[i])
        }
    }
    
    /// Mutate all pixel values.
    @inlinable
    public mutating func dataMutate(_ body: (inout T)->Void) {
        for i in 0..<data.count {
            body(&data[i])
        }
    }
    
    /// Convert all pixel values.
    @inlinable
    public func dataConverted<T2>(_ body: (T) throws -> T2) rethrows  -> Image<P, T2> {
        return try .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var p = $0.baseAddress!
            for i in 0..<$0.count {
                p.initialize(to: try body(data[i]))
                p += 1
            }
        }
    }
}
