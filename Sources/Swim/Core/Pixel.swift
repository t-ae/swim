import Foundation

public struct Pixel<P: PixelType, T: DataType> {

    public internal(set) var data: [T]
    
    public init(data: [T]) {
        precondition(data.count == P.channels, "Size of `data` must be exact same as the number of channels.")
        self.data = data
    }
    
    init() {
        self.init(data: [T](repeating: T.swimDefaultValue, count: P.channels))
    }
    
    public init(value: T) {
        self.init(data: [T](repeating: value, count: P.channels))
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
    
    public init(intensityAlpha: [T]) {
        self.init(intensityAlpha: intensityAlpha)
    }
}

// MARK: RGB
extension Pixel where P == RGB {
    public init(r: T, g: T, b: T) {
        self.init(data: [r, g, b])
    }
    
    public init(rgb: [T]) {
        self.init(data: rgb)
    }
}

// MARK: RGBA
extension Pixel where P == RGBA {
    public init(r: T, g: T, b: T, a: T) {
        self.init(data: [r, g, b, a])
    }
    
    public init(rgba: [T]) {
        self.init(data: rgba)
    }
}

// MARK: ARGB
extension Pixel where P == ARGB {
    public init(a: T, r: T, g: T, b: T) {
        self.init(data: [a, r, g, b])
    }
    
    public init(argb: [T]) {
        self.init(data: argb)
    }
}
