// TODO: Replace with uninitialized initializer when Swift5.1 is out.
// https://github.com/apple/swift-evolution/blob/master/proposals/0245-array-uninitialized-initializer.md

extension Image {
    /// Create `Image` by filling `PixelRef`s.
    ///
    /// `initializer` takes `UnsafePixelRef`, which is uninitialized at first.
    /// You must initialize all pixel values of `UnsafePixelRef`.
    ///
    /// - Note: `UnsafePixelRef` contains `UnsafeMutableBufferPointer`. So it's unsafe to bring it outside closure.
    @inlinable
    public static func createWithUnsafePixelRef(width: Int,
                                                height: Int,
                                                initializer: (UnsafePixelRef<P, T>)->Void) -> Image {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var start = 0
            for y in 0..<height {
                for x in 0..<width {
                    let slice = bp[start..<start+P.channels]
                    let ref = UnsafePixelRef<P, T>(x: x, y: y, rebasing: slice)
                    initializer(ref)
                    start += P.channels
                }
            }
        }
    }
    
    /// Create `Image` by computing pixel values from their coords.
    ///
    /// `initializer` takes 3 arguments, x, y, and c.
    /// You have to compute pixel values with these arguments and return it.
    @inlinable
    public static func createWithPixelValues(width: Int,
                                             height: Int,
                                             initializer: (_ x: Int, _ y: Int, _ c: P)->T) -> Image {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var i = 0
            for y in 0..<height {
                for x in 0..<width {
                    for c in 0..<P.channels {
                        bp[i] = initializer(x, y, P(rawValue: c)!)
                        i += 1
                    }
                }
            }
        }
    }
    
    /// Create `Image` with filling `UnsafeMutableBufferPointer`.
    ///
    /// `UnsafeMutableBufferPointer` must be initialized at the end of closure's execution.
    @inlinable
    public static func createWithUnsafeMutableBufferPointer(width: Int,
                                                            height: Int,
                                                            initializer: (UnsafeMutableBufferPointer<T>)->Void) -> Image {
        var image = Image<P, T>(width: width, height: height, value: T.swimDefaultValue)
        
        image.withUnsafeMutableBufferPointer { bp in
            initializer(bp)
        }
        
        return image
    }
}
