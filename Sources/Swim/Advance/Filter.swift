
extension Image where P == Intensity, T: Comparable {
    func _filter(kernelSize: Int, kernelFunc: ([T])->T) -> Image<P, T> {
        precondition(kernelSize > 0)
        var ret = self
        
        let kernelRange = -(kernelSize-1)/2...kernelSize/2
        
        for y in 0..<height {
            for x in 0..<width {
                let patch = kernelRange.flatMap { dy -> [T] in
                    let yy = y+dy
                    guard 0 <= y+dy && yy < height else {
                        return []
                    }
                    return kernelRange.flatMap { dx -> [T] in
                        let xx = x+dx
                        guard 0 <= xx && xx < width else {
                            return []
                        }
                        return [self[xx, yy]]
                    }
                }
                ret[x, y] = kernelFunc(patch)
            }
        }
        
        return ret
    }
    
    func _minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _filter(kernelSize: kernelSize) { $0.min()! }
    }
    
    func _maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _filter(kernelSize: kernelSize) { $0.max()! }
    }
    
    func _medianFilter(kernelSize: Int) -> Image<P, T> {
        return _filter(kernelSize: kernelSize) { $0.median()! }
    }
    
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _minimumFilter(kernelSize: kernelSize)
    }
    
    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _maximumFilter(kernelSize: kernelSize)
    }
    
    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        return _medianFilter(kernelSize: kernelSize)
    }
}



