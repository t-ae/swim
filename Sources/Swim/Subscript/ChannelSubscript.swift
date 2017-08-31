
extension Image {
    func getChannel(channel: Int) ->Image<Intensity, T> {
        assert(0 <= channel && channel <= P.channels)
        
        return converted { _, _, px in px.data[channel] }
    }
    
    mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
        assert(0 <= channel && channel <= P.channels)
        
        unsafeChannelwiseConvert {
            var dst = $0.baseAddress! + channel
            for v in newValue.data {
                dst.pointee = v
                dst += P.channels
            }
        }
    }
    
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
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

// FIXME: Wait for Swift4
/*
#if os(macOS) || os(iOS)
    import Accelerate
    
    private func strideCopy<T>(src: [T],
                            srcOffset: Int,
                            srcStride: Int,
                            dst: inout [T],
                            dstOffset: Int,
                            dstStride: Int,
                            _ copyFunc: (Int32, UnsafePointer<T>, Int32, UnsafeMutablePointer<T>, Int32)->Void) {
        
        let count = src.count / srcStride
        src.withUnsafeBufferPointer {
            let src = $0.baseAddress! + srcOffset
            dst.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress! + dstOffset
                copyFunc(Int32(count), src, Int32(srcStride), dst, Int32(dstStride))
            }
        }
    }
    
    extension Image where T == Float {
        func getChannel(channel: Int) ->Image<Intensity, T> {
            assert(0 <= channel && channel <= P.channels)
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: self.data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage.data, dstOffset: 0, dstStride: 1,
                       cblas_scopy)
            return newImage
        }
        
        mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
            assert(0 <= channel && channel <= P.channels)
            strideCopy(src: newValue.data, srcOffset: channel, srcStride: 1,
                       dst: &self.data, dstOffset: channel, dstStride: P.channels,
                       cblas_scopy)
        }
        
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get {
                precondition(0 <= channel && channel <= P.channels)
                return getChannel(channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                setChannel(channel: channel, newValue: newValue)
            }
        }
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                let channel = channel.rawValue
                return getChannel(channel: channel)
            }
            set {
                let channel = channel.rawValue
                setChannel(channel: channel, newValue: newValue)
            }
        }
    }
    
    extension Image where T == Double {
        func getChannel(channel: Int) ->Image<Intensity, T> {
            assert(0 <= channel && channel <= P.channels)
            var newImage = Image<Intensity, T>(width: width, height: height)
            strideCopy(src: self.data, srcOffset: channel, srcStride: P.channels,
                       dst: &newImage.data, dstOffset: 0, dstStride: 1,
                       cblas_dcopy)
            return newImage
        }
        
        mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
            assert(0 <= channel && channel <= P.channels)
            strideCopy(src: newValue.data, srcOffset: channel, srcStride: 1,
                       dst: &self.data, dstOffset: channel, dstStride: P.channels,
                       cblas_dcopy)
        }
        
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get {
                precondition(0 <= channel && channel <= P.channels)
                return getChannel(channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                setChannel(channel: channel, newValue: newValue)
            }
        }
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                let channel = channel.rawValue
                return getChannel(channel: channel)
            }
            set {
                let channel = channel.rawValue
                setChannel(channel: channel, newValue: newValue)
            }
        }
    }
#endif
*/
