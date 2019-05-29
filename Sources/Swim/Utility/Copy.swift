@inlinable
func copy<S: RandomAccessCollection, T>(src: S,
                                        dst: inout [T],
                                        count: Int) where S.Index == Int, S.Element == T {
    assert(src.count >= count)
    assert(dst.count >= count)
    
    for i in 0..<count {
        dst[i] = src[i]
    }
}

@inlinable
func copy<S: RandomAccessCollection, T>(src: S,
                                        dst: UnsafeMutableBufferPointer<T>,
                                        count: Int) where S.Index == Int, S.Element == T {
    assert(src.count >= count)
    assert(dst.count >= count)
    
    for i in 0..<count {
        dst[i] = src[i]
    }
}

@inlinable
func strideCopy<S: RandomAccessCollection, T>(src: S, srcOffset: Int, srcStride: Int,
                                              dst: inout [T], dstOffset: Int, dstStride: Int,
                                              count: Int) where S.Index == Int, S.Element == T {
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
func strideCopy<S: RandomAccessCollection, T>(src: S, srcOffset: Int, srcStride: Int,
                                              dst: UnsafeMutableBufferPointer<T>, dstOffset: Int, dstStride: Int,
                                              count: Int) where S.Index == Int, S.Element == T {
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
