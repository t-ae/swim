// TODO: Replace with uninitialized initializer when Swift5.1 is out.
// https://github.com/apple/swift-evolution/blob/master/proposals/0245-array-uninitialized-initializer.md

extension Image {
    @inlinable
    public static func createWithPixelRef(width: Int,
                                          height: Int,
                                          initializer: (PixelRef<P, T>)->Void) -> Image {
        var image = Image<P, T>(width: width, height: height)
        
        image.pixelwiseConvert(initializer)
        
        return image
    }
    
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
