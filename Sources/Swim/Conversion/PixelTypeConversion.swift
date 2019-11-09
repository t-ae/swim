// MARK: - Gray -> RGB
extension Image where P == Gray {
    /// Create `Image<GrayAlpha, T>` by filling alpha channel with specified `alphaValue`.
    @inlinable
    public func toGrayAlpha(with alphaValue: T) -> Image<GrayAlpha, T> {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var p = $0.baseAddress!
            for i in 0..<pixelCount {
                p.initialize(to: data[i])
                p += 1
                p.initialize(to: alphaValue)
                p += 1
            }
        }
    }
    
    /// Create grayscale `Image<RGB, T>`.
    @inlinable
    public func toRGB() -> Image<RGB, T> {
        return .createWithUnsafePixelRef(width: width, height: height) { ref in
            ref.pointer.initialize(repeating: self[ref.x, ref.y, .gray])
        }
    }
    
    @inlinable
    func toRGBWithAlpha<P2: RGBWithAlpha>(with alphaValue: T) -> Image<P2, T> {
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            var p = bp.baseAddress!
            for i in 0..<data.count {
                p.advanced(by: P2.colorStartIndex).initialize(repeating: data[i], count: 3)
                p.advanced(by: P2.alphaIndex).initialize(to: alphaValue)
                p += 4
            }
        }
    }
    
    /// Create grayscale `Image<RGBA, T>` with specified `alphaValue`.
    @inlinable
    public func toRGBA(with alphaValue: T) -> Image<RGBA, T> {
        return toRGBWithAlpha(with: alphaValue)
    }
    
    /// Create grayscale `Image<ARGB, T>` with specified `alphaValue`.
    @inlinable
    public func toARGB(with alphaValue: T) -> Image<ARGB, T> {
        return toRGBWithAlpha(with: alphaValue)
    }
}

// MARK: GrayAlpha -> RGBWithAlpha
extension Image where P == GrayAlpha {
    @inlinable
    func toRGBWithAlpha<P2: RGBWithAlpha>() -> Image<P2, T> {
        return unsafePixelwiseConverted { src, dst in
            dst.initialize(channel: P2.redIndex, to: src[.gray])
            dst.initialize(channel: P2.greenIndex, to: src[.gray])
            dst.initialize(channel: P2.blueIndex, to: src[.gray])
            dst.initialize(channel: P2.alphaIndex, to: src[.alpha])
        }
    }
    
    /// Create grayscale `Image<RGBA, T>`.
    @inlinable
    public func toRGBA() -> Image<RGBA, T> {
        return toRGBWithAlpha()
    }
    
    /// Create grayscale `Image<ARGB, T>`.
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
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var p = $0.baseAddress!
            for i in 0..<pixelCount {
                var sum = wr * T2(data[3*i+0])
                sum += wg * T2(data[3*i+1])
                sum += wb * T2(data[3*i+2])
                p.initialize(to: T(sum))
                p += 1
            }
        }
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
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) {
            var p = $0.baseAddress!
            for i in 0..<pixelCount {
                p.initialize(to: wr * data[3*i+0])
                p.pointee += wg * data[3*i+1]
                p.pointee += wb * data[3*i+2]
                p += 1
            }
        }
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
        return unsafePixelwiseConverted { src, dst in
            dst.initialize(channel: P2.redIndex, to: src[.red])
            dst.initialize(channel: P2.greenIndex, to: src[.green])
            dst.initialize(channel: P2.blueIndex, to: src[.blue])
            dst.initialize(channel: P2.alphaIndex, to: alphaValue)
        }
    }
    
    /// Create `Image<RGBA, T>` with specified `alphaValue`.
    @inlinable
    public func toRGBA(with alphaValue: T) -> Image<RGBA, T> {
        return toRGBWithAlpha(with: alphaValue)
    }
    
    /// Create `Image<ARGB, T>` with specified `alphaValue`.
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
        return unsafePixelwiseConverted { src, dst in
            dst.initialize(channel: .red, to: src[P.redIndex])
            dst.initialize(channel: .green, to: src[P.greenIndex])
            dst.initialize(channel: .blue, to: src[P.blueIndex])
        }
    }
}

// MARK: - RGBA <-> ARGB
extension Image where P == RGBA {
    /// Create `Image<ARGB, T>` by permuting channels.
    @inlinable
    public func toARGB() -> Image<ARGB, T> {
        return unsafePixelwiseConverted { src, dst in
            dst.initialize(channel: .red, to: src[.red])
            dst.initialize(channel: .green, to: src[.green])
            dst.initialize(channel: .blue, to: src[.blue])
            dst.initialize(channel: .alpha, to: src[.alpha])
        }
    }
}

extension Image where P == ARGB {
    /// Create `Image<RGBA, T>` by permuting channels.
    @inlinable
    public func toRGBA() -> Image<RGBA, T> {
        return unsafePixelwiseConverted { src, dst in
            dst.initialize(channel: .red, to: src[.red])
            dst.initialize(channel: .green, to: src[.green])
            dst.initialize(channel: .blue, to: src[.blue])
            dst.initialize(channel: .alpha, to: src[.alpha])
        }
    }
}

