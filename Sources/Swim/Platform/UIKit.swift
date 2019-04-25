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
    /// All pixel values will be in [0, 1] range.
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
    /// All pixel values will be clipped to [0, 1] range.
    @inlinable
    public func uiImage() -> UIImage {
        return UIImage(cgImage: cgImage())
    }
}

#endif
