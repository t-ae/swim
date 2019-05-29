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
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            for i in 0..<data.count {
                bp[3*i+0] = data[i]
                bp[3*i+1] = data[i]
                bp[3*i+2] = data[i]
            }
        }
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
    /// Create grayscale image by weighted sum.
    ///
    /// Output = wr*R + wg*G + wb*B.
    @inlinable
    public func toGray<T2: BinaryFloatingPoint>(wr: T2, wg: T2, wb: T2) -> Image<Gray, T> {
        var newImage = Image<Gray, T>.zeros(like: self)
        
        for i in 0..<width*height {
            var sum = wr * T2(data[3*i+0])
            sum += wg * T2(data[3*i+1])
            sum += wb * T2(data[3*i+2])
            newImage.data[i] = T(sum)
        }
        
        return newImage
    }
    
    /// Create grayscale image.
    ///
    /// Output = 0.2126*R + 0.7152*G + 0.0722*B.
    @inlinable
    public func toGray() -> Image<Gray, T> {
        return toGray(wr: 0.2126, wg: 0.7152, wb: 0.0722)
    }
}

extension Image where P == RGB, T: FloatingPoint {
    /// Create grayscale image by weighted sum.
    ///
    /// Output = wr*R + wg*G + wb*B.
    @inlinable
    public func toGray(wr: T, wg: T, wb: T) -> Image<Gray, T> {
        var newImage = Image<Gray, T>.zeros(like: self)
        
        for i in 0..<width*height {
            newImage.data[i] = wr * data[3*i+0]
            newImage.data[i] += wg * data[3*i+1]
            newImage.data[i] += wb * data[3*i+2]
        }
        
        return newImage
    }
}

extension Image where P == RGB, T: BinaryFloatingPoint {
    /// Create grayscale image.
    ///
    /// Output = 0.2126*R + 0.7152*G + 0.0722*B.
    @inlinable
    public func toGray() -> Image<Gray, T> {
        return toGray(wr: 0.2126, wg: 0.7152, wb: 0.0722)
    }
}


extension Image where P == RGB {
    @inlinable
    func toRGBWithAlpha<P2: RGBWithAlpha>(with alphaValue: T) -> Image<P2, T> {
        return pixelwiseConverted { src, dst in
            dst[P2.redIndex] = src[.red]
            dst[P2.greenIndex] = src[.green]
            dst[P2.blueIndex] = src[.blue]
            dst[P2.alphaIndex] = alphaValue
        }
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
    ///
    /// This method simply discards alpha channel.
    @inlinable
    public func toRGB() -> Image<RGB, T> {
        return pixelwiseConverted { src, dst in
            dst[.red] = src[P.redIndex]
            dst[.green] = src[P.greenIndex]
            dst[.blue] = src[P.blueIndex]
        }
    }
}

// MARK: - RGBA <-> ARGB
extension Image where P == RGBA {
    @inlinable
    public func toARGB() -> Image<ARGB, T> {
        return pixelwiseConverted { src, dst in
            dst[.red] = src[.red]
            dst[.green] = src[.green]
            dst[.blue] = src[.blue]
            dst[.alpha] = src[.alpha]
        }
    }
}

extension Image where P == ARGB {
    @inlinable
    public func toRGBA() -> Image<RGBA, T> {
        return pixelwiseConverted { src, dst in
            dst[.red] = src[.red]
            dst[.green] = src[.green]
            dst[.blue] = src[.blue]
            dst[.alpha] = src[.alpha]
        }
    }
}

