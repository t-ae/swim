
#if os(macOS) || os(iOS)
    import Accelerate
    
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
