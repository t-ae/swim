public enum EdgeMode<P: PixelType, T: DataType> {
    case constant(pixel: Pixel<P, T>)
    case edge
    case symmetric
    case reflect
    case wrap
    
    public static func constant(value: T) -> EdgeMode<P, T> {
        return .constant(pixel: Pixel(value: value))
    }
}

extension EdgeMode where T: AdditiveArithmetic {
    public static var zero: EdgeMode<P, T> {
        return .constant(value: .zero)
    }
}

extension EdgeMode {
    @inlinable
    func clampValue(value: Int, max: Int) -> Int? {
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
            var x = value
            if x < 0 {
                x.negate()
            }
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
