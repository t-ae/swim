#if canImport(AppKit)

import AppKit

extension Image where P: ConvertibleFromCGImage, T == UInt8 {
    @inlinable
    public init?(nsImage: NSImage) {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil,hints: nil) else {
            return nil
        }
        self = P.fromCGImage(cgImage: cgImage)
    }
}

extension Image where P: ConvertibleToCGImage, T == UInt8 {
    @inlinable
    public func nsImage() -> NSImage {
        return NSImage(cgImage: P.toCGImage(image: self), size: .zero)
    }
}

extension Image where P: ConvertibleFromCGImage, T == Float {
    @inlinable
    public init?(nsImage: NSImage) {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil,hints: nil) else {
            return nil
        }
        let uint8 = P.fromCGImage(cgImage: cgImage)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P: ConvertibleToCGImage, T == Float {
    @inlinable
    public func nsImage() -> NSImage {
        let i255 = clipped(low: 0, high: 1) * 255
        let uint8 = Image<P, UInt8>(uncheckedCast: i255)
        return NSImage(cgImage: P.toCGImage(image: uint8), size: .zero)
    }
}

extension Image where P: ConvertibleFromCGImage, T == Double {
    @inlinable
    public init?(nsImage: NSImage) {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil,hints: nil) else {
            return nil
        }
        let uint8 = P.fromCGImage(cgImage: cgImage)
        self.init(cast: uint8)
        self /= T(UInt8.max)
    }
}

extension Image where P: ConvertibleToCGImage, T == Double {
    @inlinable
    public func nsImage() -> NSImage {
        let i255 = clipped(low: 0, high: 1) * 255
        let uint8 = Image<P, UInt8>(uncheckedCast: i255)
        return NSImage(cgImage: P.toCGImage(image: uint8), size: .zero)
    }
}

#endif
