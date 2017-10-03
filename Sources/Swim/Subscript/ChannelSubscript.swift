
extension Image {
    func getChannel(channel: Int) ->Image<Intensity, T> {
        assert(0 <= channel && channel < P.channels)
        var newImage = Image<Intensity, T>(width: width, height: height)
        strideCopy(src: _data, srcOffset: channel, srcStride: P.channels,
                   dst: &newImage._data, dstOffset: 0, dstStride: 1,
                   count: newImage._data.count)
        return newImage
    }
    
    mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
        assert(0 <= channel && channel < P.channels)
        precondition(size == newValue.size)
        strideCopy(src: newValue._data, srcOffset: 0, srcStride: 1,
                   dst: &_data, dstOffset: channel, dstStride: P.channels,
                   count: newValue._data.count)
    }
    
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel < P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel < P.channels)
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
            assert(0 <= channel && channel < P.channels)
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: _data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage._data, dstOffset: 0, dstStride: 1,
                       count: newImage._data.count)
            return newImage
        }
        
        mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
            assert(0 <= channel && channel < P.channels)
            precondition(size == newValue.size)
            strideCopy(src: newValue._data, srcOffset: 0, srcStride: 1,
                       dst: &_data, dstOffset: channel, dstStride: P.channels,
                       count: newValue._data.count)
        }
    }
    
    extension Image where T == Double {
        func getChannel(channel: Int) ->Image<Intensity, T> {
            assert(0 <= channel && channel < P.channels)
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: _data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage._data, dstOffset: 0, dstStride: 1,
                       count: newImage._data.count)
            return newImage
        }
        
        mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
            assert(0 <= channel && channel < P.channels)
            precondition(size == newValue.size)
            strideCopy(src: newValue._data, srcOffset: 0, srcStride: 1,
                       dst: &_data, dstOffset: channel, dstStride: P.channels,
                       count: newValue._data.count)
        }
    }
#endif
