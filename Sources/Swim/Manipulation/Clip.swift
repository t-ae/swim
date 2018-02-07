
extension Image where T: Comparable {
    mutating func _clip(low: T, high: T) {
        self._channelwiseConvert { Swift.max(Swift.min($0, high), low) }
    }
    
    public mutating func clip(low: T, high: T) {
        self._clip(low: low, high: high)
    }
    
    public func clipped(low: T, high: T) -> Image<P, T> {
        var newImage = self
        newImage._clip(low: low, high: high)
        return newImage
    }
}

// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    extension Image where T == Float {
        mutating func _clip(low: T, high: T) {
            var low = low
            var high = high
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                vDSP_vclip(p, 1, &low, &high, p, 1, vDSP_Length($0.count))
            }
        }
        
        public func clipped(low: T, high: T) -> Image<P, T> {
            var newImage = self
            newImage._clip(low: low, high: high)
            return newImage
        }
    }
    
    extension Image where T == Double {
        mutating func _clip(low: T, high: T) {
            var low = low
            var high = high
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                vDSP_vclipD(p, 1, &low, &high, p, 1, vDSP_Length($0.count))
            }
        }
        
        public func clipped(low: T, high: T) -> Image<P, T> {
            var newImage = self
            newImage._clip(low: low, high: high)
            return newImage
        }
    }
#endif
