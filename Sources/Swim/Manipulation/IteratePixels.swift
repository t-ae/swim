extension Image {
    /// Execute `f` for each pixel.
    @inlinable
    public func iteratePixels(_ f: (PixelRef<P, T>)->Void) {
        iteratePixels(0..<width, 0..<height, f)
    }
    
    /// Execute `f` for each pixel in specified range.
    @inlinable
    public func iteratePixels(_ xRange: Range<Int>,
                              _ yRange: Range<Int>,
                              _ f: (PixelRef<P, T>)->Void) {
        data.withUnsafeBufferPointer { src in
            var rowStart = dataIndex(x: xRange.startIndex, y: yRange.startIndex)
            for y in yRange {
                var start = rowStart
                for x in xRange {
                    let ref = PixelRef<P, T>(x: x, y: y, rebasing: src[start..<start+P.channels])
                    
                    f(ref)
                    start += P.channels
                }
                rowStart += width * P.channels
            }
        }
    }
}
