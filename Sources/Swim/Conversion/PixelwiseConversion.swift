
import Foundation

// MARK: - Same Pixel/Data type conversion
extension Image {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for (x, y, px) in self {
                let newPx = f(x, y, px)
                newPx.data.withUnsafeBufferPointer {
                    let src = $0.baseAddress!
                    memcpy(dst, src, P.channels*MemoryLayout<T>.size)
                }
                dst += P.channels
            }
        }
    }
}

extension Image where P == Intensity {
    public mutating func convert(_ f: (Int, Int, T)->T) {
        self.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for (x, y, px) in self {
                dst.pointee = f(x, y, px.value)
                dst += P.channels
            }
        }
    }
}

// MARK: - General conversion
extension PixelSequence where Iterator == PixelIterator<PT, DT> {
    public func converted<T2: DataType>(_ f: (Int, Int, Pixel<PT, DT>)->T2) -> Image<Intensity, T2> {
        var data = [T2](repeating: 0, count: width*height)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for (x, y, px) in self {
                dst.pointee = f(x, y, px)
                dst += 1
            }
        }
        return Image<Intensity, T2>(width: width, height: height, data: data)
    }
    
    public func converted<P2, T2>(_ f: (Int, Int, Pixel<PT, DT>)->Pixel<P2, T2>) -> Image<P2, T2> {
        var data = [T2](repeating: 0, count: width*height*P2.channels)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for (x, y, px) in self {
                let out = f(x, y, px)
                out.data.withUnsafeBufferPointer {
                    let src = $0.baseAddress!
                    memcpy(dst, src, P2.channels*MemoryLayout<T2>.size)
                }
                dst += P2.channels
            }
        }
        return Image<P2, T2>(width: width, height: height, data: data)
    }
}

extension PixelSequence where Iterator == PixelIterator<Intensity, DT> {
    public func converted<T2: DataType>(_ f: @escaping (Int, Int, DT)->T2) -> Image<Intensity, T2> {
        var data = [T2](repeating: 0, count: width*height)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for (x, y, px) in self {
                dst.pointee = f(x, y, px.value)
                dst += 1
            }
        }
        return Image<Intensity, T2>(width: width, height: height, data: data)
    }
    
    public func converted<P2, T2>(_ f: @escaping (Int, Int, DT)->Pixel<P2, T2>) -> Image<P2, T2> {
        var data = [T2](repeating: 0, count: width*height*P2.channels)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for (x, y, px) in self {
                let out = f(x, y, px.value)
                out.data.withUnsafeBufferPointer {
                    let src = $0.baseAddress!
                    memcpy(dst, src, P2.channels*MemoryLayout<T2>.size)
                }
                dst += P2.channels
            }
        }
        return Image<P2, T2>(width: width, height: height, data: data)
    }
}