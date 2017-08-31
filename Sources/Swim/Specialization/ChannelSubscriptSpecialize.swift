
extension Image where P == Intensity, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}


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
    
    extension Image where P == Intensity, T == Float {
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
    
    extension Image where P == Intensity, T == Double {
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

    extension Image where P == RGB, T == Float {
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
    
    extension Image where P == RGB, T == Double {
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

    extension Image where P == RGBA, T == Float {
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
    
    extension Image where P == RGBA, T == Double {
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

    extension Image where P == ARGB, T == Float {
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
    
    extension Image where P == ARGB, T == Double {
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

#else
    extension Image where P == Intensity, T == Float {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

    extension Image where P == Intensity, T == Double {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

    extension Image where P == RGB, T == Float {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

    extension Image where P == RGB, T == Double {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

    extension Image where P == RGBA, T == Float {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

    extension Image where P == RGBA, T == Double {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

    extension Image where P == ARGB, T == Float {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

    extension Image where P == ARGB, T == Double {
        public subscript(channel channel: Int) -> Image<Intensity, T> {
            get{
                precondition(0 <= channel && channel <= P.channels)
                return self.getChannel(image: self, channel: channel)
            }
            set {
                precondition(0 <= channel && channel <= P.channels)
                self.setChannel(image: &self, channel: channel, newValue: newValue)
            }
        }
        
        public subscript(channel channel: P) -> Image<Intensity, T> {
            get {
                return self.getChannel(image: self, channel: channel.rawValue)
            }
            set {
                self.setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
            }
        }
    }

#endif