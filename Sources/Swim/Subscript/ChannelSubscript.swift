
private func getChannel<I: PixelSequence>(image: I, channel: Int) ->Image<Intensity, I.DT> where I.Iterator == PixelIterator<I.PT, I.DT> {
    return image.converted { _, _, px in px.data[channel] }
}

private func setChannel<P, T>(image: inout Image<P, T>, channel: Int, newValue: Image<Intensity, T>) {
    image.unsafeChannelwiseConvert {
        var dst = $0.baseAddress! + channel
        for v in newValue.data {
            dst.pointee = v
            dst += P.channels
        }
    }
}

extension Image {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(image: self, channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(image: &self, channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(image: self, channel: channel.rawValue)
        }
        set {
            setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension ImageSlice {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        return getChannel(image: self, channel: channel)
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        return getChannel(image: self, channel: channel.rawValue)
    }
}

#if os(macOS) || os(iOS)
    import Accelerate
    
    private func strideCopy<T: DataType>(src: [T],
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
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get {
                precondition(0 <= channel && channel <= P.channels)
                var data = [T](repeating: 0, count: width*height)
                strideCopy(src: self.data, srcOffset: channel, srcStride: P.channels,
                           dst: &data, dstOffset: 0, dstStride: 1,
                           cblas_scopy)
                return Image<Intensity, T>(width: width, height: height, data: data)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                strideCopy(src: newValue.data, srcOffset: channel, srcStride: 1,
                           dst: &self.data, dstOffset: channel, dstStride: P.channels,
                           cblas_scopy)
            }
        }
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                let channel = channel.rawValue
                var data = [T](repeating: 0, count: width*height)
                strideCopy(src: self.data, srcOffset: channel, srcStride: P.channels,
                           dst: &data, dstOffset: 0, dstStride: 1,
                           cblas_scopy)
                return Image<Intensity, T>(width: width, height: height, data: data)
            }
            set {
                let channel = channel.rawValue
                strideCopy(src: newValue.data, srcOffset: channel, srcStride: 1,
                           dst: &self.data, dstOffset: channel, dstStride: P.channels,
                           cblas_scopy)
            }
        }
    }
    
    extension Image where T == Double {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get {
                precondition(0 <= channel && channel <= P.channels)
                var data = [T](repeating: 0, count: width*height)
                strideCopy(src: self.data, srcOffset: channel, srcStride: P.channels,
                           dst: &data, dstOffset: 0, dstStride: 1,
                           cblas_dcopy)
                return Image<Intensity, T>(width: width, height: height, data: data)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                strideCopy(src: newValue.data, srcOffset: channel, srcStride: 1,
                           dst: &self.data, dstOffset: channel, dstStride: P.channels,
                           cblas_dcopy)
            }
        }
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                let channel = channel.rawValue
                var data = [T](repeating: 0, count: width*height)
                strideCopy(src: self.data, srcOffset: channel, srcStride: P.channels,
                           dst: &data, dstOffset: 0, dstStride: 1,
                           cblas_dcopy)
                return Image<Intensity, T>(width: width, height: height, data: data)
            }
            set {
                let channel = channel.rawValue
                strideCopy(src: newValue.data, srcOffset: channel, srcStride: 1,
                           dst: &self.data, dstOffset: channel, dstStride: P.channels,
                           cblas_dcopy)
            }
        }
    }
#endif
