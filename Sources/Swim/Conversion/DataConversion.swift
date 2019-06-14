extension Image {
    /// Convert all pixel values.
    @inlinable
    public mutating func dataConvert(_ body: (T)->T) {
        for i in 0..<data.count {
            data[i] = body(data[i])
        }
    }
    
    /// Convert all pixel values.
    @inlinable
    public func dataConverted<T2>(_ body: (T) throws -> T2) rethrows  -> Image<P, T2> {
        return try .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            for i in 0..<bp.count {
                bp[i] = try body(data[i])
            }
        }
    }
}
