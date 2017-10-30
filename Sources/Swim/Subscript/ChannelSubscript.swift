
extension Image {
    func getChannel(channel: Int) ->Image<Intensity, T> {
        precondition(0 <= channel && channel < P.channels, "Index out of range.")
        var newImage = Image<Intensity, T>(width: width, height: height)
        strideCopy(src: data, srcOffset: channel, srcStride: P.channels,
                   dst: &newImage.data, dstOffset: 0, dstStride: 1,
                   count: newImage.data.count)
        return newImage
    }
    
    mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
        precondition(0 <= channel && channel < P.channels, "Index out of range.")
        precondition(size == newValue.size, "Invalid `size`.")
        strideCopy(src: newValue.data, srcOffset: 0, srcStride: 1,
                   dst: &data, dstOffset: channel, dstStride: P.channels,
                   count: newValue.data.count)
    }
    
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            return getChannel(channel: channel)
        }
        set {
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

#if os(macOS) || os(iOS)
    import Accelerate
 
    extension Image where T == Float {
        func getChannel(channel: Int) ->Image<Intensity, T> {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage.data, dstOffset: 0, dstStride: 1,
                       count: newImage.data.count)
            return newImage
        }
        
        mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            precondition(size == newValue.size, "Images must have same size.")
            strideCopy(src: newValue.data, srcOffset: 0, srcStride: 1,
                       dst: &data, dstOffset: channel, dstStride: P.channels,
                       count: newValue.data.count)
        }
    }
    
    extension Image where T == Double {
        func getChannel(channel: Int) ->Image<Intensity, T> {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage.data, dstOffset: 0, dstStride: 1,
                       count: newImage.data.count)
            return newImage
        }
        
        mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            precondition(size == newValue.size, "Images must have same size.")
            strideCopy(src: newValue.data, srcOffset: 0, srcStride: 1,
                       dst: &data, dstOffset: channel, dstStride: P.channels,
                       count: newValue.data.count)
        }
    }
#endif
