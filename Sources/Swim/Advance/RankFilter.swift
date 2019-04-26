public enum RankFilterMode {
    case minimum, maximum, median
}

extension Image where P == Intensity, T: Comparable {
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
    
    @inlinable
    func rankFilter(kernelSize: Int, kernelFunc: ([T])->T) -> Image<P, T> {
        precondition(kernelSize > 0)
        var newImage = self
        
        let kernelRange: ClosedRange<Int>
        do {
            let l = (1-kernelSize)/2
            let r = kernelSize/2
            kernelRange = l...r
        }
        
        for y in 0..<height {
            for x in 0..<width {
                var patch: [T] = []
                patch.reserveCapacity(kernelSize*kernelSize)
                for dy in kernelRange {
                    let yy = y+dy
                    guard 0 <= yy && yy < height else {
                        continue
                    }
                    for dx in kernelRange {
                        let xx = x+dx
                        guard 0 <= xx && xx < width else {
                            continue
                        }
                        patch.append(self[xx, yy, .intensity])
                    }
                }
                newImage[x, y, .intensity] = kernelFunc(patch)
            }
        }
        
        return newImage
    }
}
