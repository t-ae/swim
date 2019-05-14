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
extension Image where P: RGBWithAlpha {
    @inlinable
    func permuteAlpha<P2: RGBWithAlpha>() -> Image<P2, T> {
        var newImage = Image<P2, T>(width: width, height: height)
        
        var srcAlpha = P.alphaIndex
        var srcColor = P.redIndex
        var dstAlpha = P2.alphaIndex
        var dstColor = P2.redIndex
        
        for _ in 0..<width*height {
            newImage.data[dstAlpha] = data[srcAlpha]
            newImage.data[dstColor+0] = data[srcColor+0]
            newImage.data[dstColor+1] = data[srcColor+1]
            newImage.data[dstColor+2] = data[srcColor+2]
            
            srcAlpha += P.channels
            srcColor += P.channels
            dstAlpha += P2.channels
            dstColor += P2.channels
        }
        
        return newImage
    }
}

extension Image where P == RGBA {
    @inlinable
    public func toARGB() -> Image<ARGB, T> {
        return permuteAlpha()
    }
}

extension Image where P == ARGB {
    @inlinable
    public func toRGBA() -> Image<RGBA, T> {
        return permuteAlpha()
    }
}

