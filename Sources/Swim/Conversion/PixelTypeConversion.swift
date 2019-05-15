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
        
        for i in 0..<width*height {
            let sum = Int(data[3*i+0]) + Int(data[3*i+1]) + Int(data[3*i+2])
            newImage.data[i] = T(sum / 3)
        }
        
        return newImage
    }
    
    @inlinable
    public func toLuminance() -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>.zeros(like: self)
        
        for i in 0..<width*height {
            var sum = 2126 * Int(data[3*i+0])
            sum += 7152 * Int(data[3*i+1])
            sum += 0722 * Int(data[3*i+2])
            newImage.data[i] = T(sum / 10000)
        }
        
        return newImage
    }
}

extension Image where P == RGB, T: FloatingPoint {
    @inlinable
    public func toBrightness() -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>.zeros(like: self)
        
        for i in 0..<width*height {
            newImage.data[i] = (data[3*i+0] + data[3*i+1] + data[3*i+2]) / 3
        }
        
        return newImage
    }
}

extension Image where P == RGB, T: BinaryFloatingPoint {
    @inlinable
    public func toLuminance() -> Image<Intensity, T> {
        var newImage = Image<Intensity, T>.zeros(like: self)
        
        for i in 0..<width*height {
            newImage.data[i] = 0.2126 * data[3*i+0]
            newImage.data[i] += 0.7152 * data[3*i+1]
            newImage.data[i] += 0.0722 * data[3*i+2]
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
extension Image where P: RGBWithAlpha {
    /// Extract RGB image.
    /// This method simply ignores alpha channel.
    @inlinable
    public func toRGB() -> Image<RGB, T> {
        var newImage = Image<RGB, T>(width: width, height: height)

        var srcColor = P.redIndex
        var dstColor = RGB.red.rawValue

        for _ in 0..<width*height {
            newImage.data[dstColor+0] = data[srcColor+0]
            newImage.data[dstColor+1] = data[srcColor+1]
            newImage.data[dstColor+2] = data[srcColor+2]

            srcColor += P.channels
            dstColor += RGB.channels
        }

        return newImage
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

