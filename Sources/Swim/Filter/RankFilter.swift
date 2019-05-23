public enum RankFilterMode {
    case minimum, maximum, median
}

extension Image where P == Gray, T: Comparable {
    @inlinable
    public func rankFilter(_ mode: RankFilterMode, kernelSize: Int) -> Image<P, T> {
        switch mode {
        case .minimum:
            return rankFilter(kernelSize: kernelSize) { $0.min()! }
        case .maximum:
            return rankFilter(kernelSize: kernelSize) { $0.max()! }
        case .median:
            return rankFilter(kernelSize: kernelSize) { $0.median()! }
        }
    }
    
    /// Apply non-linear local filter.
    @inlinable
    func rankFilter(kernelSize: Int, kernelFunc: ([T])->T) -> Image<P, T> {
        precondition(kernelSize > 0)
        var newImage = self
        
        let pad = (kernelSize - 1) / 2
        for y in 0..<height {
            for x in 0..<width {
                var patch: [T] = []
                patch.reserveCapacity(kernelSize*kernelSize)
                
                for yy in max(y-pad, 0)..<min(y-pad+kernelSize, height) {
                    for xx in max(x-pad, 0)..<min(x-pad+kernelSize, width) {
                        patch.append(self[xx, yy, .gray])
                    }
                }
                newImage[x, y, .gray] = kernelFunc(patch)
            }
        }
        
        return newImage
    }
}
