extension Image where T: Comparable {
    /// Find minimum/maximum pixel values.
    @inlinable
    public func extrema() -> (min: T, max: T) {
        var min = data[0]
        var max = data[0]
        
        for i in 1..<data.count {
            min = Swift.min(data[i], min)
            max = Swift.max(data[i], max)
        }
        
        return (min, max)
    }
    
    /// Find minimum/maximum pixel values of given `channel`.
    @inlinable
    public func extrema(channel: P) -> (min: T, max: T) {
        var p = channel.rawValue
        var min = data[p]
        var max = data[p]
        p += P.channels
        
        for _ in 1..<pixelCount {
            min = Swift.min(data[p], min)
            max = Swift.max(data[p], max)
            
            p += P.channels
        }
        
        return (min, max)
    }
}
