
import Foundation

// MARK: - Intensity -> RGB
extension Image where P == Intensity {
    func _toRGB() -> Image<RGB, T> {
        var ret = Image<RGB, T>(width: width, height: height)
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            ret.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<width*height {
                    dst.pointee = src.pointee
                    dst += 1
                    dst.pointee = src.pointee
                    dst += 1
                    dst.pointee = src.pointee
                    dst += 1
                    
                    src += 1
                }
            }
        }
        return ret
    }
    
    public func toRGB() -> Image<RGB, T> {
        return _toRGB()
    }
}

// MARK: - RGB -> Intensity
extension Image where P == RGB, T: BinaryInteger {
    func _toBrightness() -> Image<Intensity, T> {
        return _converted { px -> T in
            let r: T = px[P.red]
            let g: T = px[P.green]
            let b: T = px[P.blue]
            let sum = r + g + b + 1
            return sum / 3
        }
    }
    
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    func _toLuminance() -> Image<Intensity, T> {
        return _converted { px -> T in
            let r = 2126*px[P.red]
            let g = 7152*px[P.green]
            let b = 722*px[P.blue]
            return (r + g + b) / 10000
        }
    }
    
    public func toLuminance() -> Image<Intensity, T> {
        return _toLuminance()
    }
}

extension Image where P == RGB, T == UInt8 {
    @available(*, deprecated, message: "Could cause overflow.")
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    @available(*, deprecated, message: "Could cause overflow.")
    public func toLuminance() -> Image<Intensity, T> {
        return _toLuminance()
    }
}

extension Image where P == RGB, T: FloatingPoint {
    func _toBrightness() -> Image<Intensity, T> {
        return _converted { px -> T in
            let r = px[P.red]
            let g = px[P.green]
            let b = px[P.blue]
            return (r + g + b) / 3
        }
    }
    
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    func _toLuminance() -> Image<Intensity, T> {
        return _converted { px -> T in
            let r = 2126 * px[P.red] / 10000
            let g = 7152 * px[P.green] / 10000
            let b = 0722 * px[P.blue] / 10000
            return r + g + b
        }
    }
    
    public func toLuminance() -> Image<Intensity, T> {
        return _toLuminance()
    }
}

// MARK: - RGB -> RGBWithAlpha
func imageFromRGB<P: RGBWithAlpha, T>(image: Image<RGB, T>, alpha: T) -> Image<P, T> {
    var newImage = Image<P, T>(width: image.width, height: image.height, value: alpha)
    image.data.withUnsafeBufferPointer {
        var src = $0.baseAddress!
        newImage.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress! + P.redIndex
            for _ in 0..<image.width*image.height {
                memcpy(dst, src, RGB.channels * MemoryLayout<T>.size)
                src += RGB.channels
                dst += P.channels
            }
        }
    }
    
    return newImage
}

extension Image where P: RGBWithAlpha {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
}

// MARK: - RGBWithAlpha -> RGB
func imageFromRGBWithAlpha<P: RGBWithAlpha, T>(image: Image<P, T>) -> Image<RGB, T> {
    var newImage = Image<RGB, T>(width: image.width, height: image.height)
    image.data.withUnsafeBufferPointer {
        var src = $0.baseAddress! + P.redIndex
        newImage.data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<image.width*image.height {
                memcpy(dst, src, RGB.channels * MemoryLayout<T>.size)
                dst += RGB.channels
                src += P.channels
            }
        }
    }
    return newImage
}

extension Image where P == RGB {
    public init<P: RGBWithAlpha>(image: Image<P, T>) {
        self = imageFromRGBWithAlpha(image: image)
    }
}

// MARK: - RGBA <-> ARGB

func permuteChannels<T>(data: [T], permutation: [Int]) -> [T] {
    assert(Set(permutation) == Set(0..<permutation.count))
    var ret = data
    let numChannels = permutation.count
    
    data.withUnsafeBufferPointer {
        var src = $0.baseAddress!
        ret.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            
            for _ in 0..<data.count/permutation.count {
                for c in 0..<numChannels {
                    dst[c] = src[permutation[c]]
                }
                src += numChannels
                dst += numChannels
            }
        }
    }
    
    return ret
}
extension Image where P == RGBA {
    public init(image: Image<ARGB, T>) {
        let data = permuteChannels(data: image.data, permutation: [1, 2, 3, 0])
        self.init(width: image.width, height: image.height, data: data)
    }
}

extension Image where P == ARGB {
    public init(image: Image<RGBA, T>) {
        let data = permuteChannels(data: image.data, permutation: [3, 0, 1, 2])
        self.init(width: image.width, height: image.height, data: data)
    }
}

