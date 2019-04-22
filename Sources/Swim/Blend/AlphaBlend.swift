import Foundation

extension Blender {
    @inlinable
    public static func alphaBlend<P1: RGBWithAlpha, P2: RGBWithAlpha, T: FloatingPoint>(
        top: Image<P1, T>, bottom: inout Image<P2, T>) {
        
        precondition(top.size == bottom.size, "Images must have same size.")
        let (width, height) = top.size
        
        top.data.withUnsafeBufferPointer {
            var srcColor = $0.baseAddress! + P1.redIndex
            var srcAlpha = $0.baseAddress! + P1.alphaIndex
            bottom.data.withUnsafeMutableBufferPointer {
                var dstColor = $0.baseAddress! + P2.redIndex
                var dstAlpha = $0.baseAddress! + P2.alphaIndex
                
                for _ in 0..<width*height {
                    if srcAlpha.pointee != 0 {
                        let blendAlpha = srcAlpha.pointee + (1-srcAlpha.pointee)*dstAlpha.pointee
                        for _ in 0..<P1.channels-1 {
                            dstColor.pointee *= (1-srcAlpha.pointee)*dstAlpha.pointee
                            dstColor.pointee += srcColor.pointee * srcAlpha.pointee
                            dstColor.pointee /= blendAlpha
                            srcColor += 1
                            dstColor += 1
                        }
                        dstAlpha.pointee = blendAlpha
                        srcColor += 1
                        dstColor += 1
                    } else {
                        srcColor += P1.channels
                        dstColor += P2.channels
                    }
                    srcAlpha += P1.channels
                    dstAlpha += P2.channels
                }
            }
        }
    }
}

extension Blender {
    @inlinable
    public static func alphaBlend<P: RGBWithAlpha, T: FloatingPoint>(
        src: Image<P, T>, dst: inout Image<RGB, T>) {
        precondition(src.size == dst.size, "Images must have same size.")
        let (width, height) = src.size
        src.data.withUnsafeBufferPointer {
            var srcColor = $0.baseAddress! + P.redIndex
            var srcAlpha = $0.baseAddress! + P.alphaIndex
            dst.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<width*height {
                    if srcAlpha.pointee != 0 {
                        for _ in 0..<RGB.channels {
                            dst.pointee *= 1-srcAlpha.pointee
                            dst.pointee += srcColor.pointee * srcAlpha.pointee
                            srcColor += 1
                            dst += 1
                        }
                        srcColor += P.channels - RGB.channels
                    } else {
                        dst += RGB.channels
                        srcColor += P.channels
                    }
                    srcAlpha += P.channels
                }
            }
        }
    }
}
