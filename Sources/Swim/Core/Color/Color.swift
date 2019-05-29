import Foundation

public struct Color<P: PixelType, T: DataType> {
    @usableFromInline
    var data: ArraySlice<T>
    
    @inlinable
    public init(data: [T]) {
        self.init(data: data[...])
    }
    
    @inlinable
    init(data: ArraySlice<T>) {
        precondition(data.count == P.channels, "Size of `data` must be exact same as the number of channels.")
        self.data = data
    }
    
    @inlinable
    public init(value: T) {
        self.init(data: [T](repeating: value, count: P.channels))
    }
    
    /// Create copy of `data` and set it as buffer.
    ///
    /// If `Color` is got by `image[x, y]`, `data` is slice of original `image.data`.
    /// Even when image is discarded, this slice refers original buffer and prolong its lifetime.
    /// This method can be used to avoid that.
    @inlinable
    public mutating func ensureOwnBuffer() {
        data = Array(data)[...]
    }
}

extension Color {
    @inlinable
    public init<C: ColorProtocol>(from color: C) where C.P == P, C.T == T {
        self.init(data: color.withUnsafeBufferPointer(Array.init))
    }
    
    // Special case
    @inlinable
    public init(from pixel: Pixel<P, T>) {
        self = pixel.color
    }
}

extension Color where T: AdditiveArithmetic {
    public static var zero: Color {
        return Color<P, T>(value: .zero)
    }
}

extension Color: Equatable where T: Equatable {
    @inlinable
    public static func ==(lhs: Color, rhs: Color) -> Bool {
        return lhs.data == rhs.data
    }
}

extension Color {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
            return data[channel + data.startIndex]
        }
        set {
            data[channel + data.startIndex] = newValue
        }
    }
    
    @inlinable
    public subscript(channel: P) -> T {
        get {
            return self[channel.rawValue]
        }
        set {
            self[channel.rawValue] = newValue
        }
    }
}

// MARK: Gray
extension Color where P == Gray {
    @inlinable
    public init(gray: T) {
        self.init(data: [gray])
    }
}

// MARK: GrayAlpha
extension Color where P == GrayAlpha {
    @inlinable
    public init(gray: T, alpha: T) {
        self.init(data: [gray, alpha])
    }
    
    @inlinable
    public init(grayAlpha: [T]) {
        self.init(data: grayAlpha)
    }
}

// MARK: RGB
extension Color where P == RGB {
    @inlinable
    public init(r: T, g: T, b: T) {
        self.init(data: [r, g, b])
    }
    
    @inlinable
    public init(rgb: [T]) {
        self.init(data: rgb)
    }
}

// MARK: RGBA
extension Color where P == RGBA {
    @inlinable
    public init(r: T, g: T, b: T, a: T) {
        self.init(data: [r, g, b, a])
    }
    
    @inlinable
    public init(rgba: [T]) {
        self.init(data: rgba)
    }
}

// MARK: ARGB
extension Color where P == ARGB {
    @inlinable
    public init(a: T, r: T, g: T, b: T) {
        self.init(data: [a, r, g, b])
    }
    
    @inlinable
    public init(argb: [T]) {
        self.init(data: argb)
    }
}
