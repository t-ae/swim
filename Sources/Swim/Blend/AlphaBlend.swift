
import Foundation

extension Image where P == RGB, T: BinaryFloatingPoint {
    mutating func _alphaBlend<P2: RGBWithAlpha>(image: Image<P2, T>) {
        precondition(size == image.size)
        
        image.data.withUnsafeBufferPointer {
            var srcColor = $0.baseAddress! + P2.redIndex
            var srcAlpha = $0.baseAddress! + P2.alphaIndex
            unsafeChannelwiseConvert {
                var dst = $0.baseAddress!
                
                for _ in 0..<pixelCount {
                    for _ in 0..<P.channels {
                        dst.pointee *= 1-srcAlpha.pointee
                        dst.pointee += srcColor.pointee * srcAlpha.pointee
                        srcColor += 1
                        dst += 1
                    }
                    srcColor += P2.channels - P.channels
                    srcAlpha += P2.channels
                }
            }
        }
    }
}

extension Image where P: RGBWithAlpha, T: BinaryFloatingPoint {
    mutating func _alphaBlend(image: Image<P, T>) {
        precondition(size == image.size)
        
        image.data.withUnsafeBufferPointer {
            var srcColor = $0.baseAddress! + P.redIndex
            var srcAlpha = $0.baseAddress! + P.alphaIndex
            unsafeChannelwiseConvert {
                var dstColor = $0.baseAddress! + P.redIndex
                var dstAlpha = $0.baseAddress! + P.alphaIndex
                
                for _ in 0..<pixelCount {
                    let blendAlpha = srcAlpha.pointee + (1-srcAlpha.pointee)*dstAlpha.pointee
                    for _ in 0..<P.channels {
                        dstColor.pointee *= (1-srcAlpha.pointee)*dstAlpha.pointee
                        dstColor.pointee += srcColor.pointee * srcAlpha.pointee
                        dstColor.pointee /= blendAlpha
                        srcColor += 1
                        dstColor += 1
                    }
                    dstAlpha.pointee = blendAlpha
                    srcColor += P.channels - P.channels
                    srcAlpha += P.channels
                    dstColor += P.channels - P.channels
                    dstAlpha += P.channels
                }
            }
        }
    }
}
