
extension Image where T: Comparable {
    mutating func _clip(low: T, high: T) {
        self._channelwiseConvert { Swift.max(Swift.min($0, high), low) }
    }
    
    public mutating func clip(low: T, high: T) {
        self._clip(low: low, high: high)
    }
    
    public func clipped(low: T, high: T) -> Image<P, T> {
        var ret = self
        ret._clip(low: low, high: high)
        return ret
    }
}

// MARK: - Accelerate
#if os(macOS) || os(iOS)
    import Accelerate
    
    extension Image where T == Float {
        public mutating func clip(low: Float, high: Float) {
            var low = low
            var high = high
            self.unsafeChannelwiseConvert {
                let p = $0.baseAddress!
                vDSP_vclip(p, 1, &low, &high, p, 1, vDSP_Length(self.data.count))
            }
        }
        
        public func clipped(low: Float, high: Float) -> Image<P, Float> {
            var ret = self
            ret.clip(low: low, high: high)
            return ret
        }
    }
    
    extension Image where T == Double {
        public mutating func clip(low: Double, high: Double) {
            var low = low
            var high = high
            self.unsafeChannelwiseConvert {
                let p = $0.baseAddress!
                vDSP_vclipD(p, 1, &low, &high, p, 1, vDSP_Length(self.data.count))
            }
        }
        
        public func clipped(low: Double, high: Double) -> Image<P, Double> {
            var ret = self
            ret.clip(low: low, high: high)
            return ret
        }
    }
#else
    extension Image where T == Float {
        public mutating func clip(low: Float, high: Float) {
            self._clip(low: low, high: high)
        }
        
        public func clipped(low: Float, high: Float) -> Image<P, Float> {
            var ret = self
            ret._clip(low: low, high: high)
            return ret
        }
    }
    
    extension Image where T == Double {
        public mutating func clip(low: Double, high: Double) {
            self._clip(low: low, high: high)
        }
        
        public func clipped(low: Double, high: Double) -> Image<P, Double> {
            var ret = self
            ret._clip(low: low, high: high)
            return ret
        }
    }
#endif
