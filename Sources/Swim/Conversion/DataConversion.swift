
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
    public func dataConverted<T2>(_ body: (T) -> T2) -> Image<P, T2> {
        return Image<P, T2>.createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            for i in 0..<bp.count {
                bp[i] = body(data[i])
            }
        }
    }
}
