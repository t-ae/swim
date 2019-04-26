@inlinable
func strideCopy<T>(src: [T], srcOffset: Int, srcStride: Int,
                   dst: inout [T], dstOffset: Int, dstStride: Int,
                   count: Int) {
    src.withUnsafeBufferPointer {
        var src = $0.baseAddress! + srcOffset
        dst.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress! + dstOffset
            for _ in 0..<count {
                dst.pointee = src.pointee
                src += srcStride
                dst += dstStride
            }
        }
    }
}
