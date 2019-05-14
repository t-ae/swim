@inlinable
func strideCopy<T>(src: [T], srcOffset: Int, srcStride: Int,
                   dst: inout [T], dstOffset: Int, dstStride: Int,
                   count: Int) {
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
