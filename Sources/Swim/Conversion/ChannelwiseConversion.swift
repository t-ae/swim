
extension Image {
    mutating func channelwiseConvert(_ f: (DT)->DT) {
        self.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for _ in 0..<data.count {
                p.pointee = f(p.pointee)
                p += 1
            }
        }
    }
}

extension PixelSequence where Iterator == PixelIterator<PT, DT> {
    func channelwiseConverted<T2: DataType>(_ f: (DT)->T2) -> Image<PT, T2> {
        var data = [T2](repeating: 0, count: width*height*PT.channels)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for (_, _, px) in self {
                px.data.withUnsafeBufferPointer {
                    var src = $0.baseAddress!
                    for _ in 0..<PT.channels {
                        dst.pointee = f(src.pointee)
                        src += 1
                        dst += 1
                    }
                }
            }
        }
        return Image(width: width, height: height, data: data)
    }
}
