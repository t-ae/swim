extension Image {
    /// Concatenate given `images` horizontally.
    @inlinable
    public static func concatH(_ images: [Image<P, T>]) -> Image<P, T> {
        let width: Int = images.map { $0.width }.reduce(0, +)
        let height: Int = images[0].height
        precondition(images.allSatisfy { $0.height == height }, "All images must have same `height`.")
        
        var image = Image<P, T>(width: width, height: height)
        
        var start = 0
        for im in images {
            let cols: Range<Int> = start..<start+im.width
            image[cols: cols] = im
            start += im.width
        }
        
        return image
    }
}

extension Image {
    /// Concatenate given `images` vertically.
    @inlinable
    public static func concatV(_ images: [Image<P, T>]) -> Image<P, T> {
        let width: Int = images[0].width
        let height: Int = images.map { $0.height }.reduce(0, +)
        
        precondition(images.allSatisfy { $0.width == width }, "All images must have same `width`.")
        
        var image = Image<P, T>(width: width, height: height)
        
        var start = 0
        for im in images {
            let rows = start..<start+im.height
            image[rows: rows] = im
            start += im.height
        }
        
        return image
    }
}

extension Image {
    /// Concatenate given `images`.
    ///
    /// First `images` in inner array will be concatenated horizontally.
    /// Then all horizontally-concatenated images will be concatenated vertically.
    @inlinable
    public static func concat(_ images: [[Image<P, T>]]) -> Image<P, T> {
        let colConcated = images.map { concatH($0) }
        return concatV(colConcated)
    }
}
