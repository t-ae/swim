extension Image {
    /// Concatenate given `images` horizontally.
    @inlinable
    public static func concatH(_ images: [Image<P, T>]) -> Image<P, T> {
        let width: Int = images.map { $0.width }.reduce(0, +)
        let height: Int = images[0].height
        precondition(images.allSatisfy { $0.height == height }, "All images must have same `height`.")
        
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var start = 0
            for y in 0..<height {
                for i in 0..<images.count {
                    copy(src: images[i].data, srcOffset: images[i].dataIndex(x: 0, y: y),
                         dst: bp, dstOffset: start, count: images[i].width*P.channels)
                    start += images[i].width*P.channels
                }
            }
        }
    }
}

extension Image {
    /// Concatenate given `images` vertically.
    @inlinable
    public static func concatV(_ images: [Image<P, T>]) -> Image<P, T> {
        let width: Int = images[0].width
        let height: Int = images.map { $0.height }.reduce(0, +)
        
        precondition(images.allSatisfy { $0.width == width }, "All images must have same `width`.")
        
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var start = 0
            for i in 0..<images.count {
                copy(src: images[i].data, srcOffset: 0,
                     dst: bp, dstOffset: start, count: images[i].data.count)
                start += images[i].data.count
            }
        }
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
