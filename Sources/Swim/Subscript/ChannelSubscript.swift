extension Image {
    /// Access the grayscale image in specified channel.
    ///
    /// The complexity is `O(width*height)`
    @inlinable
    public subscript(channel channel: Int) -> Image<Gray, T> {
        get{
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            
            return .createWithUnsafeMutableBufferPointer(width: width, height: height) { dst in
                strideCopy(src: data, srcOffset: channel, srcStride: P.channels,
                           dst: dst, dstOffset: 0, dstStride: 1, count: dst.count)
            }
        }
        set {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            precondition(size == newValue.size, "Invalid `size`.")
            
            strideCopy(src: newValue.data, srcOffset: 0, srcStride: 1,
                       dst: &data, dstOffset: channel, dstStride: P.channels,
                       count: newValue.data.count)
        }
    }
    
    /// Access the grayscale image in specified channel.
    ///
    /// The complexity is `O(width*height)`.
    @inlinable
    public subscript(channel channel: P) -> Image<Gray, T> {
        get {
            return self[channel: channel.rawValue]
        }
        set {
            self[channel: channel.rawValue] = newValue
        }
    }
}
