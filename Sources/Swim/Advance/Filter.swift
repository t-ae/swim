extension Image where P == Intensity, T: Comparable {
    @usableFromInline
    func filter(kernelSize: Int, kernelFunc: ([T])->T) -> Image<P, T> {
        precondition(kernelSize > 0)
        var newImage = self
        
        let kernelRange: CountableClosedRange<Int>
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
                newImage[unsafe: x, y, .intensity] = kernelFunc(patch)
            }
        }
        
        return newImage
    }
    
    @inlinable
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        return filter(kernelSize: kernelSize) { $0.min()! }
    }
    
    @inlinable
    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        return filter(kernelSize: kernelSize) { $0.max()! }
    }
    
    @inlinable
    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        return filter(kernelSize: kernelSize) { $0.median()! }
    }
}

#if canImport(Accelerate)

import Accelerate

extension Image where P == Intensity, T == Float {
    @inlinable
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        let (m, n, matrix) = im2col(patchWidth: kernelSize,
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
    
    @inlinable
    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        let (m, n, matrix) = im2col(patchWidth: kernelSize,
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
    
    @inlinable
    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        let (m, n, matrix) = im2col(patchWidth: kernelSize,
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
    @inlinable
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        let (m, n, matrix) = im2col(patchWidth: kernelSize,
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
    
    @inlinable
    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        let (m, n, matrix) = im2col(patchWidth: kernelSize,
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
    
    @inlinable
    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        let (m, n, matrix) = im2col(patchWidth: kernelSize,
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

