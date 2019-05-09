extension Image {
    @inlinable
    public func iteratePixels(_ f: (PixelRef<P, T>)->Void) {
        data.withUnsafeBufferPointer { src in
            var start = 0
            for y in 0..<height {
                for x in 0..<width {
                    let ref = PixelRef<P, T>(x: x, y: y, rebasing: src[start..<start+P.channels])

                    f(ref)
                    start += P.channels
                }
            }
        }
    }
}
