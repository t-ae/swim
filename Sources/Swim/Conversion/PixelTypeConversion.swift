
import Foundation

// MARK: - RGB -> Intensity
extension Image where P == RGB, T: BinaryFloatingPoint {
    func _toBrightness() -> Image<Intensity, T> {
        return self._converted { x, y, px in (px[.red] + px[.green] + px[.blue]) / 3 }
    }
    
    func _toLuminane() -> Image<Intensity, T> {
        return self._converted { x, y, px in 0.2126*px[.red] + 0.7152*px[.green] + 0.0722*px[.blue] }
    }
    
    public func toBrightness() -> Image<Intensity, T> {
        return self._toBrightness()
    }
    
    public func toLuminane() -> Image<Intensity, T> {
        return self._toLuminane()
    }
}

// MARK: - RGB -> RGBA
func imageFromRGB<T: DataType>(image: Image<RGB, T>, alpha: T) -> Image<RGBA, T> {
    var data = [T](repeating: alpha, count: image.width*image.height*RGBA.channels)
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
    
    return Image<RGBA, T>(width: image.width, height: image.height, data: data)
}
extension Image where P == RGBA {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
}

// MARK: - RGB -> ARGB
func imageFromRGB<T: DataType>(image: Image<RGB, T>, alpha: T) -> Image<ARGB, T> {
    var data = [T](repeating: alpha, count: image.width*image.height*ARGB.channels)
    image.data.withUnsafeBufferPointer {
        var src = $0.baseAddress!
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress! + 1
            for _ in 0..<image.width*image.height {
                memcpy(dst, src, RGB.channels * MemoryLayout<T>.size)
                src += RGB.channels
                dst += ARGB.channels
            }
        }
    }
    
    return Image<ARGB, T>(width: image.width, height: image.height, data: data)
}
extension Image where P == ARGB {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
}

// MARK: - RGBA -> RGB
func imageFromRGBA<T: DataType>(image: Image<RGBA, T>) -> Image<RGB, T> {
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
    return Image(width: image.width, height: image.height, data: data)

}
extension Image where P == RGB {
    public init(image: Image<RGBA, T>) {
        self = imageFromRGBA(image: image)
    }
}
