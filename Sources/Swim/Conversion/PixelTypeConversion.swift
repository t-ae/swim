
import Foundation

// MARK: - RGB -> Intensity
extension PixelSequence where Iterator == PixelIterator<PT, DT>, PT == RGB, DT: BinaryFloatingPoint {
    public func toBrightness() -> Image<Intensity, DT> {
        return self.converted { x, y, px in (px[.red] + px[.green] + px[.blue]) / 3 }
    }
    
    public func toLuminane() -> Image<Intensity, DT> {
        return self.converted { x, y, px in 0.2126*px[.red] + 0.7152*px[.green] + 0.0722*px[.blue] }
    }
}

// MARK: - RGB -> RGBA
extension Image where P == RGBA {
    public init(image: Image<RGB, T>, alpha: T) {
        var data = [T](repeating: alpha, count: image.width*image.height*P.channels)
        image.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<image.width*image.height {
                    memcpy(dst, src, RGB.channels * MemoryLayout<T>.size)
                    src += RGB.channels
                    dst += RGBA.channels
                }
            }
        }
        
        self.init(width: image.width, height: image.height, data: data)
    }
}

extension Image where P == RGBA, T == UInt8 {
    public init(image: Image<RGB, T>) {
        self.init(image: image, alpha: 255)
    }
}

extension Image where P == RGBA, T: BinaryFloatingPoint {
    public init(image: Image<RGB, T>) {
        self.init(image: image, alpha: 1)
    }
}

// MARK: - RGBA -> RGB
extension Image where P == RGB {
    public init(image: Image<RGBA, T>) {
        var data = [T](repeating: 0, count: RGB.channels * image.data.count / RGBA.channels)
        image.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<image.width*image.height {
                    memcpy(dst, src, RGB.channels)
                    dst += RGB.channels
                    src += RGBA.channels
                }
            }
        }
        self.init(width: image.width, height: image.height, data: data)
    }
}
