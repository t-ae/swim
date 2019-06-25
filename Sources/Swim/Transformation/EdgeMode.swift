/// Represents how to compute the color outside of image.
public enum EdgeMode<P: PixelType, T: DataType> {
    case constant(color: Color<P, T>)
    case edge
    case symmetric
    case reflect
    case wrap
    
    public static func constant(value: T) -> EdgeMode<P, T> {
        return .constant(color: Color(value: value))
    }
}

extension EdgeMode where T: AdditiveArithmetic {
    public static var zero: EdgeMode<P, T> {
        return .constant(value: .zero)
    }
}

extension EdgeMode {
    /// Clamp value into `0..<max` by self mode.
    ///
    /// Return `nil` if `self` is `.constant` and `value` is out of range.
    @inlinable
    public func clampValue(value: Int, max: Int) -> Int? {
        guard value < 0 || value >= max else {
            // Already inside
            return value
        }
        
        switch self {
        case .constant:
            return nil
        case .edge:
            return clamp(value, min: 0, max: max-1)
        case .symmetric:
            var x = value
            if x < 0 {
                x = -x - 1
            }
            x %= 2*max // Make x in [0, 2*max-1]
            if x >= max {
                x = 2*max - x - 1
            }
            return x
        case .reflect:
            if max == 1 {
                return 0
            }
            var x = abs(value)
            x %= 2*max - 2 // Make x in [0, 2*max-3]
            if x >= max {
                x = 2*max - x - 2
            }
            return x
        case .wrap:
            let x = value % max
            if x < 0 {
                return x + max
            } else {
                return x
            }
        }
    }
}

extension UnsafePixelRef {
    /// Set color of `image` at (`x`, `y`).
    /// If (`x`, `y`) is outside `image`, extrapolate by `edgeMode`.
    @inlinable
    public func setColor(x: Int, y: Int, in image: Image<P, T>, edgeMode: EdgeMode<P, T>) {
        if let x = edgeMode.clampValue(value: x, max: image.width),
            let y = edgeMode.clampValue(value: y, max: image.height) {
            setColor(x: x, y: y, in: image)
        } else if case let .constant(color) = edgeMode {
            setColor(color: color)
        } else {
            fatalError("Never happens.")
        }
    }
}

extension Image {
    /// Extrapolate color of image at (x, y).
    ///
    /// If (`x`, `y`) is inside `image`, it simply returns `image[x, y]`.
    /// Otherwise, extrapolate color by `edgeMode`.
    @inlinable
    public subscript(x: Int, y: Int, edgeMode edgeMode: EdgeMode<P, T>) -> Color<P, T> {
        if let x = edgeMode.clampValue(value: x, max: width),
            let y = edgeMode.clampValue(value: y, max: height) {
            return self[x, y]
        } else if case let .constant(color) = edgeMode {
            return color
        } else {
            fatalError("Never happens.")
        }
    }
}
