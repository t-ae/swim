
import Foundation

// MARK: - RGB -> Intensity
extension Image where P == RGB, T: BinaryFloatingPoint {
    func _toBrightness() -> Image<Intensity, T> {
        return _converted { x, y, px -> T in
            let r = px[.red]
            let g = px[.green]
            let b = px[.blue]
            return (r + g + b) / 3
        }
    }
    
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    func _toLuminane() -> Image<Intensity, T> {
        return _converted { x, y, px -> T in
            let r = 0.2126*px[.red]
            let g = 0.7152*px[.green]
            let b = 0.0722*px[.blue]
            return r + g + b
        }
    }
    
    public func toLuminane() -> Image<Intensity, T> {
        return _toLuminane()
    }
}

// MARK: - RGB -> RGBWithAlpha
func imageFromRGB<P: RGBWithAlpha, T>(image: Image<RGB, T>, alpha: T) -> Image<P, T> {
    var newImage = Image<P, T>(width: image.width, height: image.height, value: alpha)
    image._data.withUnsafeBufferPointer {
        var src = $0.baseAddress!
        newImage._data.withUnsafeMutableBufferPointer {
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
    image._data.withUnsafeBufferPointer {
        var src = $0.baseAddress! + P.redIndex
        newImage._data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<image.width*image.height {
                memcpy(dst, src, RGB.channels)
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
            
            for c in 0..<numChannels {
                dst[c] = src[permutation[c]]
            }
            src += numChannels
            dst += numChannels
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

