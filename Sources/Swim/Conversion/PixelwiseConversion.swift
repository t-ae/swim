import Foundation

// MARK: - Same Pixel/Data type conversion
extension Image {
    @inlinable
    public mutating func pixelwiseConvert(_ f: (MutablePixelRef<P, T>)->Void) {
        let (width, height) = size
        data.withUnsafeMutableBufferPointer {
            var start = 0
            for y in 0..<height {
                for x in 0..<width {
                    let pixel = MutablePixelRef<P, T>(_x: x, _y: y, rebasing: $0[start..<start+P.channels])
                    f(pixel)
                    start += P.channels
                }
            }
        }
    }
}

// MARK: - Different type conversion
extension Image {
    @inlinable
    public func pixelwiseConverted<P2, T2>(_ f: (PixelRef<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        var newImage = Image<P2, T2>(width: width, height: height)
        data.withUnsafeBufferPointer { src in
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                var start = 0
                for y in 0..<height {
                    for x in 0..<width {
                        let ref = PixelRef<P, T>(_x: x, _y: y, rebasing: src[start..<start+P.channels])
                        
                        let out = f(ref)
                        memcpy(dst, out.data, P2.channels*MemoryLayout<T2>.size)
                        
                        start += P.channels
                        dst += P2.channels
                    }
                }
            }
        }
        
        return newImage
    }
}
