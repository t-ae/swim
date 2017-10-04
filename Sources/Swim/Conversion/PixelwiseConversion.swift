
import Foundation

// MARK: - Same Pixel/Data type conversion
extension Image {
    
    mutating func _convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        
        _data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            var pixel = Pixel<P, T>(data: [T](repeating: T.swimDefaultValue, count: P.channels))
            
            for y in 0..<height {
                for x in 0..<width {
                    pixel._data.withUnsafeMutableBufferPointer {
                        _ = memcpy($0.baseAddress!, p, P.channels*MemoryLayout<T>.size)
                    }
                    let newPixel = f(x, y, pixel)
                    memcpy(p, newPixel._data, P.channels*MemoryLayout<T>.size)
                    p += P.channels
                }
            }
        }
    }
    
    mutating func _unsafeConvert(_ f: (Int, Int, UnsafeMutableBufferPointer<T>)->Void) {
        _data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            for y in 0..<height {
                for x in 0..<width {
                    let bp = UnsafeMutableBufferPointer<T>(start: p, count: P.channels)
                    f(x, y, bp)
                    p += P.channels
                }
            }
        }
    }
    
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        _convert(f)
    }
    
    public mutating func unsafeConvert(_ f: (Int, Int, UnsafeMutableBufferPointer<T>)->Void) {
        _unsafeConvert(f)
    }
}

extension Image where P == Intensity {
    mutating func _convert(_ f: (Int, Int, T)->T) {
        _data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                dst.pointee = f(x, y, px._data[0])
                dst += P.channels
            }
        }
    }
    
//    public mutating func convert(_ f: (Int, Int, T)->T) {
//        convert(f)
//    }
}

// MARK: - General conversion
extension Image {
    func _converted<T2>(_ f: (Int, Int, Pixel<P, T>)->T2) -> Image<Intensity, T2> {
        var newImage = Image<Intensity, T2>(width: width, height: height)
        newImage._data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                dst.pointee = f(x, y, px)
                dst += 1
            }
        }
        return newImage
    }
    
    public func converted<T2>(_ f: (Int, Int, Pixel<P, T>)->T2) -> Image<Intensity, T2> {
        return _converted(f)
    }
    
    func _converted<P2, T2>(_ f: (Int, Int, Pixel<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        var newImage = Image<P2, T2>(width: width, height: height)
        newImage._data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                let out = f(x, y, px)
                out._data.withUnsafeBufferPointer {
                    let src = $0.baseAddress!
                    memcpy(dst, src, P2.channels*MemoryLayout<T2>.size)
                }
                dst += P2.channels
            }
        }
        return newImage
    }
    
    public func converted<P2, T2>(_ f: (Int, Int, Pixel<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        return _converted(f)
    }
}

extension Image where P == Intensity {
    func _converted<T2>(_ f: (Int, Int, T)->T2) -> Image<Intensity, T2> {
        var newImage = Image<Intensity, T2>(width: width, height: height)
        newImage._data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                dst.pointee = f(x, y, px._data[0])
                dst += 1
            }
        }
        return newImage
    }
    
//    public func converted<T2>(_ f: (Int, Int, T)->T2) -> Image<Intensity, T2> {
//        return _converted(f)
//    }
    
    func _converted<P2, T2>(_ f: (Int, Int, T)->Pixel<P2, T2>) -> Image<P2, T2> {
        var newImage = Image<P2, T2>(width: width, height: height)
        newImage._data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            withCoord { x, y, px in
                let out = f(x, y, px._data[0])
                out._data.withUnsafeBufferPointer {
                    let src = $0.baseAddress!
                    memcpy(dst, src, P2.channels*MemoryLayout<T2>.size)
                }
                dst += P2.channels
            }
        }
        return newImage
    }
    
//    public func converted<P2, T2>(_ f: (Int, Int, T)->Pixel<P2, T2>) -> Image<P2, T2> {
//        return _converted(f)
//    }
}
