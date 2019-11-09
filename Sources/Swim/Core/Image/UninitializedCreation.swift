extension Image {
    /// Create `Image` by filling `UnsafePixelRef`s.
    ///
    /// `initializer` takes `UnsafePixelRef`, which is uninitialized at first.
    /// You are responsible to initialize all pixel values of `UnsafePixelRef`.
    ///
    /// - Note: `UnsafePixelRef` contains `UnsafeMutableBufferPointer`. So it's unsafe to bring it outside closure.
    @inlinable
    public static func createWithUnsafePixelRef(
        width: Int,
        height: Int,
        initializer: (UnsafePixelRef<P, T>) throws -> Void
    ) rethrows -> Image {
        return try .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var start = 0
            for y in 0..<height {
                for x in 0..<width {
                    let slice = bp[start..<start+P.channels]
                    let ref = UnsafePixelRef<P, T>(x: x, y: y, rebasing: slice)
                    try initializer(ref)
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
    public static func createWithPixelValues(
        width: Int,
        height: Int,
        initializer: (_ x: Int, _ y: Int, _ c: P) throws -> T
    ) rethrows -> Image {
        return try .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var i = 0
            for y in 0..<height {
                for x in 0..<width {
                    for c in 0..<P.channels {
                        bp.baseAddress!.advanced(by: i)
                            .initialize(to: try initializer(x, y, P(rawValue: c)!))
                        i += 1
                    }
                }
            }
        }
    }
    
    /// Create `Image` by filling `UnsafeMutableBufferPointer`.
    ///
    /// All values in `UnsafeMutableBufferPointer` must be initialized at the end of closure's execution.
    @inlinable
    public static func createWithUnsafeMutableBufferPointer(
        width: Int,
        height: Int,
        initializer: (UnsafeMutableBufferPointer<T>) throws -> Void
    ) rethrows -> Image {
        let dataCount = width*height*P.channels
        let data = try [T](unsafeUninitializedCapacity: dataCount) { bp, initializedCount in
            try initializer(bp)
            initializedCount = bp.count
        }
        
        return Image<P, T>(width: width, height: height, data: data)
    }
}
