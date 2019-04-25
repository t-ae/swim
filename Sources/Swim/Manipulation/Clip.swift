extension Image where T: Comparable {
    @inlinable
    public mutating func clip(low: T, high: T) {
        self.channelwiseConvert { Swift.max(Swift.min($0, high), low) }
    }
    
    @inlinable
    public func clipped(low: T, high: T) -> Image<P, T> {
        var newImage = self
        newImage.clip(low: low, high: high)
        return newImage
    }
}
