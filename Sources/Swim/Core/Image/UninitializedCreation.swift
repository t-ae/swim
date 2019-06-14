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
        var image = Image<P, T>(width: width, height: height)
        
        image.unsafePixelwiseConvert(initializer)
        
        return image
    }
    
    /// Create `Image` by computing pixel values from their coords.
    ///
    /// `initializer` takes 3 arguments, x, y, and c.
    /// You have to compute pixel values with these arguments and return it.
    @inlinable
    public static func createWithPixelValues(width: Int,
                                             height: Int,
                                             initializer: (_ x: Int, _ y: Int, _ c: P)->T) -> Image {
        var image = Image<P, T>(width: width, height: height)
        
        image.channelwiseConvert { x, y, c, value in
            initializer(x, y, c)
        }
        
        return image
    }
    
    /// Create `Image` with filling `UnsafeMutableBufferPointer`.
    ///
    /// `UnsafeMutableBufferPointer` must be initialized at the end of closure's execution.
    @inlinable
    public static func createWithUnsafeMutableBufferPointer(width: Int,
                                                            height: Int,
                                                            initializer: (UnsafeMutableBufferPointer<T>)->Void) -> Image {
        var image = Image<P, T>(width: width, height: height)
        
        image.withUnsafeMutableBufferPointer { bp in
            initializer(bp)
        }
        
        return image
    }
}
