extension Image where T: Comparable {
    @inlinable
    public mutating func clip(low: T, high: T) {
        self.dataConvert { clamp($0, min: low, max: high) }
    }
    
    @inlinable
    public func clipped(low: T, high: T) -> Image<P, T> {
        var newImage = self
        newImage.clip(low: low, high: high)
        return newImage
    }
}
