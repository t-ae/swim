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

#if canImport(Accelerate)

import Accelerate

@inlinable
func strideCopy(src: [Float], srcOffset: Int, srcStride: Int,
                dst: inout [Float], dstOffset: Int, dstStride: Int,
                count: Int) {
    
    src.withUnsafeBufferPointer {
        let src = $0.baseAddress! + srcOffset
        dst.withUnsafeMutableBufferPointer {
            let dst = $0.baseAddress! + dstOffset
            cblas_scopy(Int32(count), src, Int32(srcStride), dst, Int32(dstStride))
        }
    }
}

@inlinable
func strideCopy(src: [Double], srcOffset: Int, srcStride: Int,
                dst: inout [Double], dstOffset: Int, dstStride: Int,
                count: Int) {
    
    src.withUnsafeBufferPointer {
        let src = $0.baseAddress! + srcOffset
        dst.withUnsafeMutableBufferPointer {
            let dst = $0.baseAddress! + dstOffset
            cblas_dcopy(Int32(count), src, Int32(srcStride), dst, Int32(dstStride))
        }
    }
}

#endif
