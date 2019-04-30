#if canImport(AppKit)

import AppKit

extension Image where P: ConvertibleFromCGImage, T == UInt8 {
    /// Create Image from NSImage.
    @inlinable
    public init?(nsImage: NSImage) {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil,hints: nil) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T == UInt8 {
    /// Create NSImage.
    @inlinable
    public func nsImage() -> NSImage {
        return NSImage(cgImage: cgImage(), size: .zero)
    }
}

extension Image where P: ConvertibleFromCGImage, T == Float {
    /// Create Image from NSImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public init?(nsImage: NSImage) {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil,hints: nil) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T == Float {
    /// Create NSImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public func nsImage() -> NSImage {
        return NSImage(cgImage: cgImage(), size: .zero)
    }
}

extension Image where P: ConvertibleFromCGImage, T == Double {
    /// Create Image from NSImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public init?(nsImage: NSImage) {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil,hints: nil) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T == Double {
    /// Create NSImage.
    ///
    /// All pixel values are assumed to be in [0, 1] range.
    /// Values outside the range will be clipped.
    @inlinable
    public func nsImage() -> NSImage {
        return NSImage(cgImage: cgImage(), size: .zero)
    }
}

#endif
