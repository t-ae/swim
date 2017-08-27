
extension Image {
    public mutating func channelwiseConvert(_ f: (T)->T) {
        self.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<$0.count {
                p.pointee = f(p.pointee)
                p += 1
            }
        }
    }
    
    public func channelwiseConverted<T2: DataType>(_ f: (T) -> T2) -> Image<P, T2> {
        var data = [T2](repeating: 0, count: width*height*P.channels)
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
    
    public mutating func unsafeChannelwiseConvert(_ f: (UnsafeMutableBufferPointer<T>)->Void) {
        self.data.withUnsafeMutableBufferPointer { bp in
            f(bp)
        }
    }
    
    public func unsafeChannelwiseConverted<T2: DataType>(_ f: (UnsafeBufferPointer<T>, UnsafeMutableBufferPointer<T2>)->Void) -> Image<P, T2>{
        var data = [T2](repeating: 0, count: width*height*P.channels)
        self.data.withUnsafeBufferPointer { src in
            data.withUnsafeMutableBufferPointer { dst in
                f(src, dst)
            }
        }
        return Image<P, T2>(width: width, height: height, data: data)
    }
}
