import Foundation

public struct Pixel<P: PixelType, T: DataType> {
    @usableFromInline
    var data: [T]
    
    @inlinable
    public init(data: [T]) {
        precondition(data.count == P.channels, "Size of `data` must be exact same as the number of channels.")
        self.data = data
    }
    
    @inlinable
    public init(value: T) {
        self.init(data: [T](repeating: value, count: P.channels))
    }
}

extension Pixel where T: AdditiveArithmetic {
    public static var zero: Pixel {
        return Pixel<P, T>(value: .zero)
    }
}

extension Pixel: Equatable {
    @inlinable
    public static func == (lhs: Pixel, rhs: Pixel) -> Bool {
        return memcmp(lhs.data, rhs.data, P.channels*MemoryLayout<T>.size) == 0
    }
}

extension Pixel {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            return data[channel]
        }
        set {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            data[channel] = newValue
        }
    }
    
    @inlinable
    public subscript(channel: P) -> T {
        get {
            return data[channel.rawValue]
        }
        set {
            data[channel.rawValue] = newValue
        }
    }
}

// MARK: Intensity
extension Pixel where P == Intensity {
    @inlinable
    public init(intensity: T) {
        self.init(data: [intensity])
    }
}

// MARK: IntensityAlpha
extension Pixel where P == IntensityAlpha {
    @inlinable
    public init(intensity: T, alpha: T) {
        self.init(data: [intensity, alpha])
    }
    
    @inlinable
    public init(intensityAlpha: [T]) {
        self.init(data: intensityAlpha)
    }
}

// MARK: RGB
extension Pixel where P == RGB {
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
extension Pixel where P == RGBA {
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
extension Pixel where P == ARGB {
    @inlinable
    public init(a: T, r: T, g: T, b: T) {
        self.init(data: [a, r, g, b])
    }
    
    @inlinable
    public init(argb: [T]) {
        self.init(data: argb)
    }
}
