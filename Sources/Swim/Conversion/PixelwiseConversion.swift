import Foundation

// MARK: - Same Pixel/Data type conversion
extension Image {
    @inlinable
    public mutating func convert(_ f: (Pixel<P, T>)->Pixel<P, T>) {
        let (width, height) = size
        data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            var pixel = Pixel<P, T>(data: [T](repeating: T.swimDefaultValue, count: P.channels))
            
            for _ in 0..<width*height {
                memcpy(&pixel.data, p, P.channels*MemoryLayout<T>.size)
                let newPixel = f(pixel)
                memcpy(p, newPixel.data, P.channels*MemoryLayout<T>.size)
                p += P.channels
            }
        }
    }
    
    @inlinable
    public mutating func unsafeConvert(_ f: (UnsafeMutableBufferPointer<T>)->Void) {
        let (width, height) = size
        data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress!
            
            for _ in 0..<width*height {
                let bp = UnsafeMutableBufferPointer<T>(start: p, count: P.channels)
                f(bp)
                p += P.channels
            }
        }
    }
}

// MARK: - Intensity
extension Image where P == Intensity {
    @inlinable
    public mutating func convert(_ f: (T)->T) {
        let (width, height) = size
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<width*height {
                dst.pointee = f(dst.pointee)
                dst += P.channels
            }
        }
    }
    
    @inlinable
    public func converted<T2>(_ f: (T)->T2) -> Image<Intensity, T2> {
        var newImage = Image<Intensity, T2>(width: width, height: height)
        newImage.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for v in data {
                dst.pointee = f(v)
                dst += 1
            }
        }
        return newImage
    }
    
    @inlinable
    public func converted<P2, T2>(_ f: (T)->Pixel<P2, T2>) -> Image<P2, T2> {
        var newImage = Image<P2, T2>(width: width, height: height)
        newImage.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for v in data {
                let out = f(v)
                memcpy(dst, out.data, P2.channels*MemoryLayout<T2>.size)
                dst += P2.channels
            }
        }
        return newImage
    }
}

// MARK: - General conversion
extension Image {
    @inlinable
    public func converted<T2>(_ f: (Pixel<P, T>)->T2) -> Image<Intensity, T2> {
        var newImage = Image<Intensity, T2>(width: width, height: height)
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                var px = Pixel<P, T>()
                
                for _ in 0..<width*height {
                    memcpy(&px.data, src, P.channels*MemoryLayout<T>.size)
                    dst.pointee = f(px)
                    src += P.channels
                    dst += Intensity.channels
                }
            }
        }
        
        return newImage
    }
    
    @inlinable
    public func converted<P2, T2>(_ f: (Pixel<P, T>)->Pixel<P2, T2>) -> Image<P2, T2> {
        var newImage = Image<P2, T2>(width: width, height: height)
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                var px = Pixel<P, T>()
                
                for _ in 0..<width*height {
                    memcpy(&px.data, src, P.channels*MemoryLayout<T>.size)
                    let out = f(px)
                    memcpy(dst, out.data, P2.channels*MemoryLayout<T2>.size)
                    
                    src += P.channels
                    dst += P2.channels
                }
            }
        }
        
        return newImage
    }
}
