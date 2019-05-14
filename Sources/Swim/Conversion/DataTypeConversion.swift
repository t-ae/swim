extension Image where T: BinaryInteger {
    @inlinable
    public func cast<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2($0) }
    }
    
    @inlinable
    public func cast<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2($0) }
    }
}

extension Image where T: BinaryFloatingPoint {
    @inlinable
    public func cast<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2($0) }
    }
    
    @inlinable
    public func cast<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2($0) }
    }
}
