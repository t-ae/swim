
extension Image {
    func _filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>])->Pixel<P, T>) -> Image<P, T> {
        var ret = Image<P, T>(width: width, height: height)
        
        let d = -kernelSize/2
        
        for y in 0..<height {
            for x in 0..<width {
                var array: [Pixel<P, T>] = []
                array.reserveCapacity(kernelSize*kernelSize)
                for i in 0..<kernelSize {
                    let yy = y + d + i
                    guard 0 <= yy && yy < self.height else { continue }
                    for j in 0..<kernelSize {
                        let xx = x + d + j
                        guard 0 <= xx && xx < self.width else { continue }
                        array.append(self[xx, yy])
                    }
                }
                ret[x, y] = kernelFunc(array)
            }
        }
        
        return ret
    }
    
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where T: Numeric&Comparable {
    func _minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _filter(kernelSize: kernelSize) { pxs in
            var min = pxs.first!
            var minValue = min.data.reduce(0, +)
            for p in pxs.dropFirst() {
                let value = p.data.reduce(0, +)
                if value < minValue {
                    minValue = value
                    min = p
                }
            }
            return min
        }
    }
    
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _minimumFilter(kernelSize: kernelSize)
    }
    
    func _maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _filter(kernelSize: kernelSize) { pxs in
            var max = pxs.first!
            var maxValue = max.data.reduce(0, +)
            for p in pxs.dropFirst() {
                let value = p.data.reduce(0, +)
                if maxValue < value {
                    maxValue = value
                    max = p
                }
            }
            return max
        }
    }
    
    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _maximumFilter(kernelSize: kernelSize)
    }
    
    func _medianFilter(kernelSize: Int) -> Image<P, T> {
        return _filter(kernelSize: kernelSize) { pxs in
            let sorted = pxs.sorted { a, b in
                a.data.reduce(0, +) < b.data.reduce(0, +)
            }
            return sorted[(sorted.count-1)/2]
        }
    }
    
    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        return _medianFilter(kernelSize: kernelSize)
    }
}
