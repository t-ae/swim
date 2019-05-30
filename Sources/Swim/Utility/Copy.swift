@usableFromInline
protocol CopySource: RandomAccessCollection where Index == Int {}

extension Array: CopySource {}
extension UnsafeBufferPointer: CopySource {}

@inlinable
func copy<S: CopySource, T>(src: S, srcOffset: Int = 0,
                            dst: inout [T], dstOffset: Int = 0,
                            count: Int) where S.Element == T {
    assert(src.count >= count + srcOffset)
    assert(dst.count >= count + dstOffset)
    
    for i in 0..<count {
        dst[i+dstOffset] = src[i + srcOffset]
    }
}

@inlinable
func copy<S: CopySource, T>(src: S, srcOffset: Int = 0,
                            dst: UnsafeMutableBufferPointer<T>, dstOffset: Int = 0,
                            count: Int) where S.Element == T {
    assert(src.count >= count + srcOffset)
    assert(dst.count >= count + dstOffset)
    
    for i in 0..<count {
        dst[i+dstOffset] = src[i + srcOffset]
    }
}

@inlinable
func strideCopy<S: CopySource, T>(src: S, srcOffset: Int, srcStride: Int,
                                  dst: inout [T], dstOffset: Int, dstStride: Int,
                                  count: Int) where S.Element == T {
    assert(0 <= srcStride*(count-1) + srcOffset)
    assert(0 <= dstStride*(count-1) + dstOffset)
    assert(srcStride*(count-1) + srcOffset < src.count)
    assert(dstStride*(count-1) + dstOffset < dst.count)
    
    var si = srcOffset
    var di = dstOffset
    for _ in 0..<count {
        dst[di] = src[si]
        si += srcStride
        di += dstStride
    }
}

@inlinable
func strideCopy<S: CopySource, T>(src: S, srcOffset: Int, srcStride: Int,
                                  dst: UnsafeMutableBufferPointer<T>, dstOffset: Int, dstStride: Int,
                                  count: Int) where S.Element == T {
    assert(0 <= srcStride*(count-1) + srcOffset)
    assert(0 <= dstStride*(count-1) + dstOffset)
    assert(srcStride*(count-1) + srcOffset < src.count)
    assert(dstStride*(count-1) + dstOffset < dst.count)
    
    var si = srcOffset
    var di = dstOffset
    for _ in 0..<count {
        dst[di] = src[si]
        si += srcStride
        di += dstStride
    }
}
