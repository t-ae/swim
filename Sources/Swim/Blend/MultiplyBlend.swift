import Foundation

extension Blender {
    @inlinable
    public static func multiplyBlend<T: BinaryFloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")

        top.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    dst.pointee *= src.pointee
                    src += 1
                    dst += 1
                }
            }
        }
    }
}

#if canImport(Accelerate)

import Accelerate

extension Blender {
    @inlinable
    public static func multiplyBlend(top: Image<RGB, Float>, bottom: inout Image<RGB, Float>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                
                vDSP_vmul(src, 1, dst, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
}

extension Blender {
    @inlinable
    public static func multiplyBlend(top: Image<RGB, Double>, bottom: inout Image<RGB, Double>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                
                vDSP_vmulD(src, 1, dst, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
}

#endif
