extension Image {
    /// Access the grayscale image in specified channel.
    ///
    /// The complexity is `O(width*height)`
    @inlinable
    public subscript(channel channel: Int) -> Image<Gray, T> {
        get{
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            
            return .createWithUnsafeMutableBufferPointer(width: width, height: height) {
                var p = $0.baseAddress!
                for i in 0..<$0.count {
                    let srcOffset = i*P.channels + channel
                    p.initialize(to: data[srcOffset])
                    p += 1
                }
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
