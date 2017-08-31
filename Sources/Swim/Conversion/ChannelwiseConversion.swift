
extension Image {
    mutating func _channelwiseConvert(_ f: (T)->T) {
        data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = f(p.pointee)
                p += 1
            }
        }
    }
    
    public mutating func channelwiseConvert(_ f: (T)->T) {
        _channelwiseConvert(f)
    }
    
    func _channelwiseConverted<T2: DataType>(_ f: (T) -> T2) -> Image<P, T2> {
        var data = [T2](repeating: T2.swimDefaultValue, count: width*height*P.channels)
        self.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<$0.count {
                    dst.pointee = f(src.pointee)
                    src += 1
                    dst += 1
                }
            }
        }
        
        return Image<P, T2>(width: width, height: height, data: data)
    }
    
    public func channelwiseConverted<T2: DataType>(_ f: (T) -> T2) -> Image<P, T2> {
        return _channelwiseConverted(f)
    }
    
    public mutating func unsafeChannelwiseConvert(_ f: (UnsafeMutableBufferPointer<T>)->Void) {
        data.withUnsafeMutableBufferPointer { bp in
            f(bp)
        }
    }
    
    public func unsafeChannelwiseConverted<T2: DataType>(_ f: (UnsafeBufferPointer<T>, UnsafeMutableBufferPointer<T2>)->Void) -> Image<P, T2> {
        var data = [T2](repeating: T2.swimDefaultValue, count: width*height*P.channels)
        self.data.withUnsafeBufferPointer { src in
            data.withUnsafeMutableBufferPointer { dst in
                f(src, dst)
            }
        }
        return Image<P, T2>(width: width, height: height, data: data)
    }
}
