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

// MARK: - Accelerate
#if canImport(Accelerate)

import Accelerate

extension Image where T == Float {
    @inlinable
    public mutating func clip(low: T, high: T) {
        var low = low
        var high = high
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            vDSP_vclip(p, 1, &low, &high, p, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public func clipped(low: T, high: T) -> Image<P, T> {
        var newImage = self
        newImage.clip(low: low, high: high)
        return newImage
    }
}

extension Image where T == Double {
    @inlinable
    public mutating func clip(low: T, high: T) {
        var low = low
        var high = high
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            vDSP_vclipD(p, 1, &low, &high, p, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public func clipped(low: T, high: T) -> Image<P, T> {
        var newImage = self
        newImage.clip(low: low, high: high)
        return newImage
    }
}

#endif
