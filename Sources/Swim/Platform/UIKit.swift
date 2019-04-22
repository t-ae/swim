#if canImport(UIKit)

import UIKit

extension Image where P: ConvertibleFromCGImage, T == UInt8 {
    @inlinable
    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        self = P.fromCGImage(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T == UInt8 {
    @inlinable
    public func uiImage() -> UIImage {
        return UIImage(cgImage: P.toCGImage(image: self))
    }
}

extension Image where P: ConvertibleFromCGImage, T == Float {
    @inlinable
    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        let uint8 = P.fromCGImage(cgImage: cgImage)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P: ConvertibleToCGImage, T == Float {
    @inlinable
    public func uiImage() -> UIImage {
        let i255 = clipped(low: 0, high: 1) * 255
        let uint8 = Image<P, UInt8>(uncheckedCast: i255)
        return UIImage(cgImage: P.toCGImage(image: uint8))
    }
}

extension Image where P: ConvertibleFromCGImage, T == Double {
    @inlinable
    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        let uint8 = P.fromCGImage(cgImage: cgImage)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P: ConvertibleToCGImage, T == Double {
    @inlinable
    public func uiImage() -> UIImage {
        let i255 = clipped(low: 0, high: 1) * 255
        let uint8 = Image<P, UInt8>(uncheckedCast: i255)
        return UIImage(cgImage: P.toCGImage(image: uint8))
    }
}

#endif
