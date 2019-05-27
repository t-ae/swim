public enum RankFilterMode {
    case minimum, maximum, median
}

extension Image where T: Comparable {
    /// Apply rank filter.
    ///
    /// Filter will be applied to each channel separately.
    ///
    /// - Precondition: kernelSize > 0
    @inlinable
    public func rankFilter(_ mode: RankFilterMode, kernelSize: Int) -> Image<P, T> {
        switch mode {
        case .minimum:
            return rankFilter(kernelSize: kernelSize) { $0.min()! }
        case .maximum:
            return rankFilter(kernelSize: kernelSize) { $0.max()! }
        case .median:
            return rankFilter(kernelSize: kernelSize) { bp in
                var bp = bp
                // if count is even, take smaller one
                let mid = (bp.startIndex + bp.endIndex - 1) / 2
                
                // partial selection sort up to mid-1
                for i in bp.startIndex..<mid {
                    var minIndex = i

                    for j in (i+1)..<bp.endIndex {
                        if bp[j] < bp[minIndex] {
                            minIndex = j
                        }
                    }
                    bp.swapAt(i, minIndex)
                }

                // minimum of rest elements is median
                return bp[mid...].min()!
            }
        }
    }
    
    @inlinable
    func rankFilter(kernelSize: Int, kernelFunc: (Slice<UnsafeMutableBufferPointer<T>>)->T) -> Image<P, T> {
        precondition(kernelSize > 0, "kernelSize must be greater than 0.")
        var newImage = self
        
        let pad = (kernelSize - 1) / 2
        
        var patch = [T](repeating: T.swimDefaultValue, count: kernelSize*kernelSize)
        
        patch.withUnsafeMutableBufferPointer { patch in
            for c in 0..<P.channels {
                for y in 0..<height {
                    for x in 0..<width {
                        var count = 0
                        for yy in max(y-pad, 0)..<min(y-pad+kernelSize, height) {
                            for xx in max(x-pad, 0)..<min(x-pad+kernelSize, width) {
                                patch[count] = self[xx, yy, c]
                                count += 1
                            }
                        }
                        newImage[x, y, c] = kernelFunc(patch[..<count])
                    }
                }
            }
        }
        
        return newImage
    }
}
