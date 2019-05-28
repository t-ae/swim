/// Convert [0, 255] image to [0, 1] image.
@inlinable
func convertPixelValue<P, T: BinaryFloatingPoint>(image: Image<P, UInt8>) -> Image<P, T> {
    return image.dataConverted { value in
        T(value) / 255
    }
}

/// Convert [0, 1] image to [0, 255] image.
@inlinable
func convertPixelValue<P, T: BinaryFloatingPoint>(image: Image<P, T>) -> Image<P, UInt8> {
    return image.dataConverted { value in
        UInt8(clamp(value * 255, min: 0, max: 255).rounded())
    }
}
