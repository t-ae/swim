#if canImport(UIKit)

import UIKit

extension Image where P: ConvertibleFromCGImage, T == UInt8 {
    /// Create Image from UIImage.
    @inlinable
    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T == UInt8 {
    /// Create UIImage.
    @inlinable
    public func uiImage() -> UIImage {
        return UIImage(cgImage: cgImage())
    }
}

extension Image where P: ConvertibleFromCGImage, T: BinaryFloatingPoint {
    /// Create Image from UIImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T: BinaryFloatingPoint {
    /// Create UIImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public func uiImage() -> UIImage {
        return UIImage(cgImage: cgImage())
    }
}

#endif
