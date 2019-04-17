#if canImport(UIKit)

import UIKit

extension Image where P == RGBA, T == UInt8 {
    @inlinable
    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    @inlinable
    public func uiImage() -> UIImage {
        return UIImage(cgImage: cgImage())
    }
}

extension Image where P == RGB, T == UInt8 {
    @inlinable
    public func uiImage() -> UIImage {
        return UIImage(cgImage: cgImage())
    }
}

#endif
