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
                    let bp = UnsafeMutableBufferPointer(rebasing: $0[start..<start+P.channels])
                    let pixel = MutablePixelRef<P, T>(_x: x, _y: y, pointer: bp)
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
    public func pixelwiseConverted<P2, T2>(_ f: (Pixel<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        var newImage = Image<P2, T2>(width: width, height: height)
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                var px = Pixel<P, T>()
                
                for _ in 0..<width*height {
                    memcpy(&px.data, src, P.channels*MemoryLayout<T>.size)
                    let out = f(px)
                    memcpy(dst, out.data, P2.channels*MemoryLayout<T2>.size)
                    
                    src += P.channels
                    dst += P2.channels
                }
            }
        }
        
        return newImage
    }
}
