import Foundation

extension Blender {
    @inlinable
    public static func addBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    dst.pointee = min(dst.pointee + src.pointee, 1)
                    src += 1
                    dst += 1
                }
            }
        }
    }
    
    @inlinable
    public static func addBlend<P: RGBWithAlpha, T: FloatingPoint>(top: Image<P, T>,
                                                                   bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        let (width, height) = top.size
        
        top.data.withUnsafeBufferPointer {
            var srcColor = $0.baseAddress! + P.redIndex
            var srcAlpha = $0.baseAddress! + P.alphaIndex
            bottom.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<width*height {
                    for _ in 0..<RGB.channels {
                        dst.pointee = min(dst.pointee + srcColor.pointee * srcAlpha.pointee, 1)
                        srcColor += 1
                        dst += 1
                    }
                    srcColor += P.channels - RGB.channels
                    srcAlpha += P.channels
                }
            }
        }
    }
}

#if canImport(Accelerate)

import Accelerate

extension Blender {
    @inlinable
    public static func addBlend(top: Image<RGB, Float>, bottom: inout Image<RGB, Float>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                
                vDSP_vadd(src, 1, dst, 1, dst, 1, vDSP_Length($0.count))
                var low: Float = 0
                var high: Float = 1
                vDSP_vclip(dst, 1, &low, &high, dst, 1, vDSP_Length($0.count))
            }
        }
    }
}

extension Blender {
    @inlinable
    public static func addBlend(top: Image<RGB, Double>, bottom: inout Image<RGB, Double>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                
                vDSP_vaddD(src, 1, dst, 1, dst, 1, vDSP_Length($0.count))
                var low: Double = 0
                var high: Double = 1
                vDSP_vclipD(dst, 1, &low, &high, dst, 1, vDSP_Length($0.count))
            }
        }
    }
}

#endif
