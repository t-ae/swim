import Foundation

public struct Pixel<P: PixelType, T: DataType> {

    public var data: [T]
    
    public init(data: [T]) {
        precondition(data.count == P.channels)
        self.data = data
    }
}

extension Pixel: Equatable {
    public static func == (lhs: Pixel, rhs: Pixel) -> Bool {
        for (l, r) in zip(lhs.data, rhs.data) {
            if l != r {
                return false
            }
        }
        return true
    }
}

extension Pixel {
    public subscript(channel: Int) -> T {
        get {
            precondition(0 <= channel && channel < P.channels)
            return data[channel]
        }
        set {
            precondition(0 <= channel && channel < P.channels)
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
    
    public init(_ value: T) {
        self.init(data: [value]
        )
    }
    
    public var value: T {
        get {
            return data[0]
        }
        set {
            data[0] = newValue
        }
    }
}

// MARK: Intensity
extension Pixel where P == Intensity {
    public init(intensity: T) {
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
