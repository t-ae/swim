import Foundation

// MARK: - Same Pixel/Data type conversion
extension Image {
    /// Convert pixels.
    /// - Note: `MutablePixelRef` contains `UnsafeMutableBufferPointer`. So it's unsafe to bring it outside closure.
    @inlinable
    public mutating func pixelwiseConvert(_ f: (MutablePixelRef<P, T>)->Void) {
        pixelwiseConvert(0..<width, 0..<height, f)
    }
    
    /// Convert pixels in specified range.
    /// - Note: `MutablePixelRef` contains `UnsafeMutableBufferPointer`. So it's unsafe to bring it outside closure.
    @inlinable
    public mutating func pixelwiseConvert(_ xRange: Range<Int>,
                                          _ yRange: Range<Int>,
                                          _ f: (MutablePixelRef<P, T>)->Void) {
        precondition(0 <= xRange.startIndex && xRange.endIndex <= width, "xRagne out of range.")
        precondition(0 <= yRange.startIndex && yRange.endIndex <= height, "yRagne out of range.")
        
        var rowStart = dataIndex(x: xRange.startIndex, y: yRange.startIndex)
        let rowSize = self.width * P.channels
        
        data.withUnsafeMutableBufferPointer {
            for y in yRange {
                var start = rowStart
                for x in xRange {
                    let pixel = MutablePixelRef<P, T>(x: x, y: y, rebasing: $0[start..<start+P.channels])
                    f(pixel)
                    start += P.channels
                }
                rowStart += rowSize
            }
        }
    }
}

// MARK: - Different type conversion
extension Image {
    /// Create new image from `self` by applying `f` for each pixel.
    /// - Note: `PixelRef` contains `UnsafeBufferPointer`. So it's unsafe to bring it outside closure.
    @inlinable
    public func pixelwiseConverted<P2, T2>(_ f: (PixelRef<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        var newImage = Image<P2, T2>(width: width, height: height)
        data.withUnsafeBufferPointer { src in
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                var start = 0
                for y in 0..<height {
                    for x in 0..<width {
                        let ref = PixelRef<P, T>(x: x, y: y, rebasing: src[start..<start+P.channels])
                        
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
