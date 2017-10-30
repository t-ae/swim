import Foundation

public struct Pixel<P: PixelType, T: DataType> {

    public internal(set) var data: [T]
    
    public init(data: [T]) {
        precondition(data.count == P.channels, "Size of `data` must be exact same as the number of channels.")
        self.data = data
    }
}

extension Pixel: Equatable {
    public static func == (lhs: Pixel, rhs: Pixel) -> Bool {
        return memcmp(lhs.data, rhs.data, P.channels*MemoryLayout<T>.size) == 0
    }
}

extension Pixel {
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
    public init(_ intensity: T) {
        self.init(data: [intensity])
    }
}

// MARK: IntensityAlpha
extension Pixel where P == IntensityAlpha {
    public init(intensity: T, alpha: T) {
        self.init(data: [intensity, alpha])
    }
}

// MARK: RGB
extension Pixel where P == RGB {
    public init(r: T, g: T, b: T) {
        self.init(data: [r, g, b])
    }
}

// MARK: RGBA
extension Pixel where P == RGBA {
    public init(r: T, g: T, b: T, a: T) {
        self.init(data: [r, g, b, a])
    }
}

// MARK: ARGB
extension Pixel where P == ARGB {
    public init(a: T, r: T, g: T, b: T) {
        self.init(data: [a, r, g, b])
    }
}
