
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

#if os(macOS) || os(iOS)
    import Accelerate
    
    extension Image where P == Intensity, T == Float {
        func _minimumFilter(kernelSize: Int) -> Image<P, T> {
            let (m, n, matrix) = _im2col(patchWidth: kernelSize,
                                         patchHeight: kernelSize,
                                         padding: .constant(T.infinity))
            
            var data = [T](matrix[0..<n])
            matrix.withUnsafeBufferPointer {
                var p = $0.baseAddress! + n
                for _ in 1..<m {
                    vDSP_vmin(data, 1, p, 1, &data, 1, vDSP_Length(n))
                    p += n
                }
            }
            
            return Image(width: width, height: height, data: data)
        }
        
        func _maximumFilter(kernelSize: Int) -> Image<P, T> {
            let (m, n, matrix) = _im2col(patchWidth: kernelSize,
                                         patchHeight: kernelSize,
                                         padding: .constant(-T.infinity))
            
            var data = [T](matrix[0..<n])
            matrix.withUnsafeBufferPointer {
                var p = $0.baseAddress! + n
                for _ in 1..<m {
                    vDSP_vmax(data, 1, p, 1, &data, 1, vDSP_Length(n))
                    p += n
                }
            }
            
            return Image(width: width, height: height, data: data)
        }
        
        public func _medianFilter(kernelSize: Int) -> Image<P, T> {
            let (m, n, matrix) = _im2col(patchWidth: kernelSize,
                                         patchHeight: kernelSize,
                                         padding: .constant(T.nan))
            
            var data = [T](repeating: 0, count: n)
            var values = [T](repeating: 0, count: m)
            for i in 0..<n {
                strideCopy(src: matrix, srcOffset: i, srcStride: n,
                           dst: &values, dstOffset: 0, dstStride: 1,
                           count: m)
                data[i] = values.filter { !$0.isNaN }.median()!
            }
            return Image(width: width, height: height, data: data)
        }
    }
    
    extension Image where P == Intensity, T == Double {
        func _minimumFilter(kernelSize: Int) -> Image<P, T> {
            let (m, n, matrix) = _im2col(patchWidth: kernelSize,
                                         patchHeight: kernelSize,
                                         padding: .constant(T.infinity))
            
            var data = [T](matrix[0..<n])
            matrix.withUnsafeBufferPointer {
                var p = $0.baseAddress! + n
                for _ in 1..<m {
                    vDSP_vminD(data, 1, p, 1, &data, 1, vDSP_Length(n))
                    p += n
                }
            }
            
            return Image(width: width, height: height, data: data)
        }
        
        func _maximumFilter(kernelSize: Int) -> Image<P, T> {
            let (m, n, matrix) = _im2col(patchWidth: kernelSize,
                                         patchHeight: kernelSize,
                                         padding: .constant(-T.infinity))
            
            var data = [T](matrix[0..<n])
            matrix.withUnsafeBufferPointer {
                var p = $0.baseAddress! + n
                for _ in 1..<m {
                    vDSP_vmaxD(data, 1, p, 1, &data, 1, vDSP_Length(n))
                    p += n
                }
            }
            
            return Image(width: width, height: height, data: data)
        }
        
        public func _medianFilter(kernelSize: Int) -> Image<P, T> {
            let (m, n, matrix) = _im2col(patchWidth: kernelSize,
                                         patchHeight: kernelSize,
                                         padding: .constant(T.nan))
            
            var data = [T](repeating: 0, count: n)
            var values = [T](repeating: 0, count: m)
            for i in 0..<n {
                strideCopy(src: matrix, srcOffset: i, srcStride: n,
                           dst: &values, dstOffset: 0, dstStride: 1,
                           count: m)
                data[i] = values.filter { !$0.isNaN }.median()!
            }
            return Image(width: width, height: height, data: data)
        }
    }
#endif

