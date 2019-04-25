extension Image {
    @inlinable
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage.data, dstOffset: 0, dstStride: 1,
                       count: newImage.data.count)
            return newImage
        }
        set {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            precondition(size == newValue.size, "Invalid `size`.")
            strideCopy(src: newValue.data, srcOffset: 0, srcStride: 1,
                       dst: &data, dstOffset: channel, dstStride: P.channels,
                       count: newValue.data.count)
        }
    }
    
    @inlinable
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self[channel: channel.rawValue]
        }
        set {
            self[channel: channel.rawValue] = newValue
        }
    }
}

#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

extension Image where T == Float {
    @inlinable
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage.data, dstOffset: 0, dstStride: 1,
                       count: newImage.data.count)
            return newImage
        }
        set {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            precondition(size == newValue.size, "Images must have same size.")
            strideCopy(src: newValue.data, srcOffset: 0, srcStride: 1,
                       dst: &data, dstOffset: channel, dstStride: P.channels,
                       count: newValue.data.count)
        }
    }
    
    @inlinable
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self[channel: channel.rawValue]
        }
        set {
            self[channel: channel.rawValue] = newValue
        }
    }
}

extension Image where T == Double {
    @inlinable
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage.data, dstOffset: 0, dstStride: 1,
                       count: newImage.data.count)
            return newImage
        }
        set {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            precondition(size == newValue.size, "Images must have same size.")
            strideCopy(src: newValue.data, srcOffset: 0, srcStride: 1,
                       dst: &data, dstOffset: channel, dstStride: P.channels,
                       count: newValue.data.count)
        }
    }
    
    @inlinable
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self[channel: channel.rawValue]
        }
        set {
            self[channel: channel.rawValue] = newValue
        }
    }
}

#endif
