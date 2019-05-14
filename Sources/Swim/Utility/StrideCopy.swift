@inlinable
func strideCopy<T>(src: [T], srcOffset: Int, srcStride: Int,
                   dst: inout [T], dstOffset: Int, dstStride: Int,
                   count: Int) {
    assert((src.count - srcOffset) / srcStride >= count)
    assert((dst.count - dstOffset) / dstStride >= count)
    
    var si = srcOffset
    var di = dstOffset
    for _ in 0..<count {
        dst[di] = src[si]
        si += srcStride
        di += dstStride
    }
}
