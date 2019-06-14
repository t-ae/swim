import Foundation

// MARK: - Same Pixel/Data type conversion
extension Image {
    /// Convert pixels.
    /// - Note: `UnsafePixelRef` contains `UnsafeMutableBufferPointer`. So it's unsafe to bring it outside closure.
    @inlinable
    public mutating func unsafePixelwiseConvert(_ body: (UnsafePixelRef<P, T>)->Void) {
        unsafePixelwiseConvert(0..<width, 0..<height, body)
    }
    
    /// Convert pixels in specified range.
    /// - Note: `UnsafePixelRef` contains `UnsafeMutableBufferPointer`. So it's unsafe to bring it outside closure.
    @inlinable
    public mutating func unsafePixelwiseConvert(_ xRange: Range<Int>,
                                                _ yRange: Range<Int>,
                                                _ body: (UnsafePixelRef<P, T>)->Void) {
        precondition(0 <= xRange.startIndex && xRange.endIndex <= width, "xRagne out of range.")
        precondition(0 <= yRange.startIndex && yRange.endIndex <= height, "yRagne out of range.")
        
        var rowStart = dataIndex(x: xRange.startIndex, y: yRange.startIndex)
        let rowSize = self.width * P.channels
        
        data.withUnsafeMutableBufferPointer { bp in
            for y in yRange {
                var start = rowStart
                for x in xRange {
                    let ref = UnsafePixelRef<P, T>(x: x, y: y, rebasing: bp[start..<start+P.channels])
                    body(ref)
                    start += P.channels
                }
                rowStart += rowSize
            }
        }
    }
}

// MARK: - Different type conversion
extension Image {
    /// Create new image from `self` by applying `body` for each pixel.
    ///
    /// `body` takes two arguments. `Pixel` refers `self` pixel. `PixelRef` refers new image's pixel.
    /// You have to assign all pixel values of `PixelRef`.
    ///
    /// - Note: `UnsafePixelRef` contains `UnsafeMutableBufferPointer`. So it's unsafe to bring them outside closure.
    @inlinable
    public func unsafePixelwiseConverted<P2, T2>(_ body: (Pixel<P, T>, UnsafePixelRef<P2, T2>)->Void) -> Image<P2, T2> {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var si = 0
            var di = 0
            for y in 0..<height {
                for x in 0..<width {
                    let pixel = Pixel<P, T>(x: x, y: y, data: data[si..<si+P.channels])
                    let ref = UnsafePixelRef<P2, T2>(x: x, y: y, rebasing: bp[di..<di+P2.channels])
                    
                    body(pixel, ref)
                    
                    si += P.channels
                    di += P2.channels
                }
            }
        }
    }
}
