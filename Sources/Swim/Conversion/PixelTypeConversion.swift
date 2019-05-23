import Foundation

// MARK: - Gray -> RGB
extension Image where P == Gray {
    @inlinable
    public func toGrayAlpha(with alphaValue: T) -> Image<GrayAlpha, T> {
        var newImage = Image<GrayAlpha, T>.full(value: alphaValue, like: self)
        
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
            newImage.data[4*i+P2.redIndex] = data[i]
            newImage.data[4*i+P2.greenIndex] = data[i]
            newImage.data[4*i+P2.blueIndex] = data[i]
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

// MARK: GrayAlpha -> RGBWithAlpha
extension Image where P == GrayAlpha {
    @inlinable
    func toRGBWithAlpha<P2: RGBWithAlpha>() -> Image<P2, T> {
        var newImage = Image<P2, T>(width: width, height: height)
        
        for i in 0..<pixelCount {
            newImage.data[4*i+P2.redIndex] = data[2*i+0]
            newImage.data[4*i+P2.greenIndex] = data[2*i+0]
            newImage.data[4*i+P2.blueIndex] = data[2*i+0]
            newImage.data[4*i+P2.alphaIndex] = data[2*i+1]
        }
        
        return newImage
    }
    
    @inlinable
    public func toRGBA() -> Image<RGBA, T> {
        return toRGBWithAlpha()
    }
    
    @inlinable
    public func toARGB() -> Image<ARGB, T> {
        return toRGBWithAlpha()
    }
}

// MARK: - RGB -> Gray
extension Image where P == RGB, T: BinaryInteger {
    /// Create grayscale image.
    /// Output = (R + G + B) / 3.
    @inlinable
    public func toBrightness() -> Image<Gray, T> {
        var newImage = Image<Gray, T>.zeros(like: self)
        
        for i in 0..<width*height {
            let sum = Int(data[3*i+0]) + Int(data[3*i+1]) + Int(data[3*i+2])
            newImage.data[i] = T(sum / 3)
        }
        
        return newImage
    }
    
    /// Create grayscale image.
    /// Output = 0.2126*R + 0.7152*G + 0.0722*B.
    @inlinable
    public func toLuminance() -> Image<Gray, T> {
        var newImage = Image<Gray, T>.zeros(like: self)
        
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
    /// Create grayscale image.
    /// Output = (R + G + B) / 3.
    @inlinable
    public func toBrightness() -> Image<Gray, T> {
        var newImage = Image<Gray, T>.zeros(like: self)
        
        for i in 0..<width*height {
            newImage.data[i] = (data[3*i+0] + data[3*i+1] + data[3*i+2]) / 3
        }
        
        return newImage
    }
}

extension Image where P == RGB, T: BinaryFloatingPoint {
    /// Create grayscale image.
    /// Output = 0.2126*R + 0.7152*G + 0.0722*B.
    @inlinable
    public func toLuminance() -> Image<Gray, T> {
        var newImage = Image<Gray, T>.zeros(like: self)
        
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
                var dst = $0.baseAddress! + P2.colorStartIndex
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

        var src = P.colorStartIndex
        var dst = RGB.red.rawValue

        for _ in 0..<width*height {
            newImage.data[dst+P.redIndex] = data[src+RGB.red.rawValue]
            newImage.data[dst+P.greenIndex] = data[src+RGB.green.rawValue]
            newImage.data[dst+P.blueIndex] = data[src+RGB.blue.rawValue]

            src += P.channels
            dst += RGB.channels
        }

        return newImage
    }
}

// MARK: - RGBA <-> ARGB
extension Image where P: RGBWithAlpha {
    @inlinable
    func permuteAlpha<P2: RGBWithAlpha>() -> Image<P2, T> {
        var newImage = Image<P2, T>(width: width, height: height)
    
        var src = 0
        var dst = 0
        
        for _ in 0..<width*height {
            newImage.data[dst+P2.alphaIndex] = data[src+P.alphaIndex]
            newImage.data[dst+P2.redIndex] = data[src+P.redIndex]
            newImage.data[dst+P2.greenIndex] = data[src+P.greenIndex]
            newImage.data[dst+P2.blueIndex] = data[src+P.blueIndex]
            
            src += P.channels
            dst += P2.channels
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

