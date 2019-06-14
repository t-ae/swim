public enum RankFilterMode {
    case minimum, maximum, median
}

extension Image where T: Comparable {
    /// Apply rank filter.
    ///
    /// Filter will be applied to each channel separately.
    ///
    /// - Precondition: windowSize > 0
    @inlinable
    public func rankFilter(_ mode: RankFilterMode, windowSize: Int) -> Image<P, T> {
        switch mode {
        case .minimum:
            return rankFilter(windowSize: windowSize) { $0.min()! }
        case .maximum:
            return rankFilter(windowSize: windowSize) { $0.max()! }
        case .median:
            return rankFilter(windowSize: windowSize) { bp in
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
    func rankFilter(windowSize: Int, rankFunc: (Slice<UnsafeMutableBufferPointer<T>>)->T) -> Image<P, T> {
        precondition(windowSize > 0, "windowSize must be greater than 0.")
        
        let pad = (windowSize - 1) / 2
        
        let buffer = UnsafeMutableBufferPointer<T>.allocate(capacity: windowSize*windowSize)
        defer { buffer.deallocate() }
        
        return .createWithPixelValues(width: width, height: height) { x, y, c in
            var count = 0
            for yy in max(y-pad, 0)..<min(y-pad+windowSize, height) {
                for xx in max(x-pad, 0)..<min(x-pad+windowSize, width) {
                    buffer[count] = self[xx, yy, c]
                    count += 1
                }
            }
            return rankFunc(buffer[..<count])
        }
    }
}
