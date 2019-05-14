import Foundation

// MARK: - Intensity -> RGB
extension Image where P == Intensity {
    @inlinable
    public func toIntensityAlpha(with alphaValue: T) -> Image<IntensityAlpha, T> {
        var newImage = Image<IntensityAlpha, T>.full(value: alphaValue, like: self)
        
        strideCopy(src: data, srcOffset: 0, srcStride: 1,
                   dst: &newImage.data, dstOffset: 0, dstStride: 2, count: pixelCount)
        
        return newImage
    }
    
    @inlinable
    public func toRGB() -> Image<RGB, T> {
        var newImage = Image<RGB, T>(width: width, height: height)

        for i in 0..<data.count {
            newImage.data[3*i+0] = data[i]
            newImage.data[3*i+1] = data[i]
            newImage.data[3*i+2] = data[i]
        }
        
        return newImage
    }
    
    @inlinable
    func toRGBWithAlpha<P2: RGBWithAlpha>(with alphaValue: T) -> Image<P2, T> {
        var newImage = Image<P2, T>.full(value: alphaValue, like: self)
        
        for i in 0..<data.count {
            newImage.data[4*i+P2.redIndex+0] = data[i]
            newImage.data[4*i+P2.redIndex+1] = data[i]
            newImage.data[4*i+P2.redIndex+2] = data[i]
        }
        
        return newImage
    }
    
    @inlinable
    public func toRGBA(with alphaValue: T) -> Image<RGBA, T> {
        return toRGBWithAlpha(with: alphaValue)
    }
    @inlinable
    public func toARGB(with alphaValue: T) -> Image<ARGB, T> {
        return toRGBWithAlpha(with: alphaValue)
    }
}

// MARK: - RGB -> Intensity
extension Image where P == RGB, T: BinaryInteger {
    @inlinable
    public func toBrightness() -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>.zeros(like: self)
        self.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<width*height {
                    dst.pointee = src.pointee
                    src += 1
                    dst.pointee += src.pointee
                    src += 1
                    dst.pointee += src.pointee
                    src += 1
                    dst.pointee /= 3
                    dst += 1
                }
            }
        }
        return newImage
    }
    
    @inlinable
    public func toLuminance() -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>.zeros(like: self)
        self.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<width*height {
                    dst.pointee = 2126 * src.pointee
                    src += 1
                    dst.pointee += 7152 * src.pointee
                    src += 1
                    dst.pointee += 0722 * src.pointee
                    src += 1
                    dst.pointee /= 10000
                    dst += 1
                }
            }
        }
        return newImage
    }
}

extension Image where P == RGB, T: FloatingPoint {
    @inlinable
    public func toBrightness() -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>.zeros(like: self)
        self.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<width*height {
                    dst.pointee = src.pointee
                    src += 1
                    dst.pointee += src.pointee
                    src += 1
                    dst.pointee += src.pointee
                    src += 1
                    dst.pointee /= 3
                    dst += 1
                }
            }
        }
        
        return newImage
    }
}

extension Image where P == RGB, T: BinaryFloatingPoint {
    @inlinable
    public func toLuminance() -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>.zeros(like: self)
        self.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<width*height {
                    dst.pointee = 0.2126 * src.pointee
                    src += 1
                    dst.pointee += 0.7152 * src.pointee
                    src += 1
                    dst.pointee += 0.0722 * src.pointee
                    src += 1
                    dst += 1
                }
            }
        }
        return newImage
    }
}


extension Image where P == RGB {
    @inlinable
    func toRGBWithAlpha<P2: RGBWithAlpha>(with alphaValue: T) -> Image<P2, T> {
        var newImage = Image<P2, T>.full(value: alphaValue, like: self)
        let (width, height) = size
        
        data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress! + P2.redIndex
                for _ in 0..<width*height {
                    memcpy(dst, src, RGB.channels * MemoryLayout<T>.size)
                    src += RGB.channels
                    dst += P2.channels
                }
            }
        }
        
        return newImage
    }
    
    @inlinable
    public func toRGBA(with alphaValue: T) -> Image<RGBA, T> {
        return toRGBWithAlpha(with: alphaValue)
    }
    
    @inlinable
    public func toARGB(with alphaValue: T) -> Image<ARGB, T> {
        return toRGBWithAlpha(with: alphaValue)
    }
}

// MARK: - RGBWithAlpha -> RGB
@inlinable
func removeAlpha<P: RGBWithAlpha, T>(image: Image<P, T>) -> Image<RGB, T> {
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

extension Image where P: RGBWithAlpha {
    @inlinable
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }
}

// MARK: - RGBA <-> ARGB
@inlinable
func permuteChannels<T>(data: [T], permutation: [Int]) -> [T] {
    assert(Set(permutation) == Set(0..<permutation.count))
    var newData = data
    let numChannels = permutation.count
    
    data.withUnsafeBufferPointer {
        var src = $0.baseAddress!
        newData.withUnsafeMutableBufferPointer {
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
    
    return newData
}

extension Image where P == RGBA {
    @inlinable
    public func toARGB() -> Image<ARGB, T> {
        let data = permuteChannels(data: self.data, permutation: [3, 0, 1, 2])
        return Image<ARGB, T>(width: width, height: height, argb: data)
    }
}

extension Image where P == ARGB {
    @inlinable
    public func toRGBA() -> Image<RGBA, T> {
        let data = permuteChannels(data: self.data, permutation: [1, 2, 3, 0])
        return Image<RGBA, T>(width: width, height: height, rgba: data)
    }
}

