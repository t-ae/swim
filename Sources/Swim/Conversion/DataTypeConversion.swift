// MARK: - Generic
extension Image {
    @inlinable
    public init(cast image: Image<P, T>, to: T.Type = T.self) {
        self = image
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public init<T2: BinaryInteger>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }

    @inlinable
    public init<T2: BinaryFloatingPoint>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }
}

extension Image where T: BinaryFloatingPoint {
    @inlinable
    public init<T2: BinaryInteger>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }

    @inlinable
    public init<T2: BinaryFloatingPoint>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }
}
