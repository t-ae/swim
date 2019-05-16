extension Image where T: BinaryInteger {
    /// Convert pixel values.
    @inlinable
    public func cast<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted(T2.init(_:))
    }
    
    /// Convert pixel values.
    @inlinable
    public func cast<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted(T2.init)
    }
}

extension Image where T: BinaryFloatingPoint {
    /// Convert pixel values.
    /// Values will be rounded toward zero.
    @inlinable
    public func cast<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted(T2.init)
    }
    
    /// Convert pixel values.
    @inlinable
    public func cast<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted(T2.init)
    }
}
