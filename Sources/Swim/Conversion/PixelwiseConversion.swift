
import Foundation

// MARK: - Same Pixel/Data type conversion
extension Image {
    mutating func _convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                let newPx = f(x, y, px)
                newPx.data.withUnsafeBufferPointer {
                    let src = $0.baseAddress!
                    memcpy(dst, src, P.channels*MemoryLayout<T>.size)
                }
                dst += P.channels
            }
        }
    }
    
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        _convert(f)
    }
}

extension Image where P == Intensity {
    mutating func _convert(_ f: (Int, Int, T)->T) {
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                dst.pointee = f(x, y, px.value)
                dst += P.channels
            }
        }
    }
    
    public mutating func convert(_ f: (Int, Int, T)->T) {
        convert(f)
    }
}

// MARK: - General conversion
extension Image {
    func _converted<T2: DataType>(_ f: (Int, Int, Pixel<P, T>)->T2) -> Image<Intensity, T2> {
        var data = [T2](repeating: T2.swimDefaultValue, count: width*height)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                dst.pointee = f(x, y, px)
                dst += 1
            }
        }
        return Image<Intensity, T2>(width: width, height: height, data: data)
    }
    
    public func converted<T2: DataType>(_ f: (Int, Int, Pixel<P, T>)->T2) -> Image<Intensity, T2> {
        return _converted(f)
    }
    
    func _converted<P2, T2>(_ f: (Int, Int, Pixel<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        var data = [T2](repeating: T2.swimDefaultValue, count: width*height*P2.channels)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
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
    
    public func converted<P2, T2>(_ f: (Int, Int, Pixel<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        return _converted(f)
    }
}

extension Image where P == Intensity {
    func _converted<T2: DataType>(_ f: (Int, Int, T)->T2) -> Image<Intensity, T2> {
        var data = [T2](repeating: T2.swimDefaultValue, count: width*height)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                dst.pointee = f(x, y, px.value)
                dst += 1
            }
        }
        return Image<Intensity, T2>(width: width, height: height, data: data)
    }
    
    public func converted<T2: DataType>(_ f: (Int, Int, T)->T2) -> Image<Intensity, T2> {
        return _converted(f)
    }
    
    func _converted<P2, T2>(_ f: (Int, Int, T)->Pixel<P2, T2>) -> Image<P2, T2> {
        var data = [T2](repeating: T2.swimDefaultValue, count: width*height*P2.channels)
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
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
    
    public func converted<P2, T2>(_ f: (Int, Int, T)->Pixel<P2, T2>) -> Image<P2, T2> {
        return _converted(f)
    }
}
