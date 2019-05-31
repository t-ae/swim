// MARK: - UInt8
extension Color where P == Gray, T: BinaryInteger {
    public static var black: Color {
        return Color(gray: 0)
    }
    
    public static var gray: Color {
        return Color(gray: 128)
    }
    
    public static var white: Color {
        return Color(gray: 255)
    }
}

extension Color where P == GrayAlpha, T: BinaryInteger {
    public static var black: Color {
        return Color(gray: 0, alpha: 255)
    }
    
    public static var gray: Color {
        return Color(gray: 128, alpha: 255)
    }
    
    public static var white: Color {
        return Color(gray: 255, alpha: 255)
    }
    
    public static var transparent: Color {
        return Color(gray: 0, alpha: 0)
    }
}

extension Color where P == RGB, T: BinaryInteger {
    public static var black: Color {
        return Color(r: 0, g: 0, b: 0)
    }
    
    public static var gray: Color {
        return Color(r: 128, g: 128, b: 128)
    }
    
    public static var white: Color {
        return Color(r: 255, g: 255, b: 255)
    }
    
    public static var red: Color {
        return Color(r: 255, g: 0, b: 0)
    }
    
    public static var green: Color {
        return Color(r: 0, g: 255, b: 0)
    }
    
    public static var blue: Color {
        return Color(r: 0, g: 0, b: 255)
    }
    
    public static var cyan: Color {
        return Color(r: 0, g: 255, b: 255)
    }
    
    public static var magenta: Color {
        return Color(r: 255, g: 0, b: 255)
    }
    
    public static var yellow: Color {
        return Color(r: 255, g: 255, b: 0)
    }
}

extension Color where P: RGBWithAlpha, T: BinaryInteger {
    public static var black: Color {
        return createColor(r: 0, g: 0, b: 0, a: 255)
    }
    
    public static var gray: Color {
        return createColor(r: 128, g: 128, b: 128, a: 255)
    }
    
    public static var white: Color {
        return createColor(r: 255, g: 255, b: 255, a: 255)
    }
    
    public static var red: Color {
        return createColor(r: 255, g: 0, b: 0, a: 255)
    }
    
    public static var green: Color {
        return createColor(r: 0, g: 255, b: 0, a: 255)
    }
    
    public static var blue: Color {
        return createColor(r: 0, g: 0, b: 255, a: 255)
    }
    
    public static var cyan: Color {
        return createColor(r: 0, g: 255, b: 255, a: 255)
    }
    
    public static var magenta: Color {
        return createColor(r: 255, g: 0, b: 255, a: 255)
    }
    
    public static var yellow: Color {
        return createColor(r: 255, g: 255, b: 0, a: 255)
    }
    
    public static var transparent: Color {
        return createColor(r: 0, g: 0, b: 0, a: 0)
    }
}

// We need this to disambiguate some codes, like `image.drawText(origin: ..., color: .red)`.
extension Color where P == RGBA, T: BinaryInteger {
    public static var black: Color {
        return Color(r: 0, g: 0, b: 0, a: 255)
    }
    
    public static var gray: Color {
        return Color(r: 128, g: 128, b: 128, a: 255)
    }
    
    public static var white: Color {
        return Color(r: 255, g: 255, b: 255, a: 255)
    }
    
    public static var red: Color {
        return Color(r: 255, g: 0, b: 0, a: 255)
    }
    
    public static var green: Color {
        return Color(r: 0, g: 255, b: 0, a: 255)
    }
    
    public static var blue: Color {
        return Color(r: 0, g: 0, b: 255, a: 255)
    }
    
    public static var cyan: Color {
        return Color(r: 0, g: 255, b: 255, a: 255)
    }
    
    public static var magenta: Color {
        return Color(r: 255, g: 0, b: 255, a: 255)
    }
    
    public static var yellow: Color {
        return Color(r: 255, g: 255, b: 0, a: 255)
    }
    
    public static var transparent: Color {
        return Color(r: 0, g: 0, b: 0, a: 0)
    }
}

// MARK: - BinaryFloatingPoint

extension Color where P == Gray, T: BinaryFloatingPoint {
    public static var black: Color {
        return Color(gray: 0)
    }
    
    public static var gray: Color {
        return Color(gray: 0.5)
    }
    
    public static var white: Color {
        return Color(gray: 1)
    }
}

extension Color where P == GrayAlpha, T: BinaryFloatingPoint {
    public static var black: Color {
        return Color(gray: 0, alpha: 1)
    }
    
    public static var gray: Color {
        return Color(gray: 0.5, alpha: 1)
    }
    
    public static var white: Color {
        return Color(gray: 1, alpha: 1)
    }
    
    public static var transparent: Color {
        return Color(gray: 0, alpha: 0)
    }
}

extension Color where P == RGB, T: BinaryFloatingPoint {
    public static var black: Color {
        return Color(r: 0, g: 0, b: 0)
    }
    
    public static var gray: Color {
        return Color(r: 0.5, g: 0.5, b: 0.5)
    }
    
    public static var white: Color {
        return Color(r: 1, g: 1, b: 1)
    }
    
    public static var red: Color {
        return Color(r: 1, g: 0, b: 0)
    }
    
    public static var green: Color {
        return Color(r: 0, g: 1, b: 0)
    }
    
    public static var blue: Color {
        return Color(r: 0, g: 0, b: 1)
    }
    
    public static var cyan: Color {
        return Color(r: 0, g: 1, b: 1)
    }
    
    public static var magenta: Color {
        return Color(r: 1, g: 0, b: 1)
    }
    
    public static var yellow: Color {
        return Color(r: 1, g: 1, b: 0)
    }
}

extension Color where P: RGBWithAlpha, T: BinaryFloatingPoint {
    public static var black: Color {
        return createColor(r: 0, g: 0, b: 0, a: 1)
    }
    
    public static var gray: Color {
        return createColor(r: 0.5, g: 0.5, b: 0.5, a: 1)
    }
    
    public static var white: Color {
        return createColor(r: 1, g: 1, b: 1, a: 1)
    }
    
    public static var red: Color {
        return createColor(r: 1, g: 0, b: 0, a: 1)
    }
    
    public static var green: Color {
        return createColor(r: 0, g: 1, b: 0, a: 1)
    }
    
    public static var blue: Color {
        return createColor(r: 0, g: 0, b: 1, a: 1)
    }
    
    public static var cyan: Color {
        return createColor(r: 0, g: 1, b: 1, a: 1)
    }
    
    public static var magenta: Color {
        return createColor(r: 1, g: 0, b: 1, a: 1)
    }
    
    public static var yellow: Color {
        return createColor(r: 1, g: 1, b: 0, a: 1)
    }
    
    public static var transparent: Color {
        return createColor(r: 0, g: 0, b: 0, a: 0)
    }
}

// We need this to disambiguate some codes, like `image.drawText(origin: ..., color: .red)`.
extension Color where P == RGBA, T: BinaryFloatingPoint {
    public static var black: Color {
        return Color(r: 0, g: 0, b: 0, a: 1)
    }
    
    public static var gray: Color {
        return Color(r: 0.5, g: 0.5, b: 0.5, a: 1)
    }
    
    public static var white: Color {
        return Color(r: 1, g: 1, b: 1, a: 1)
    }
    
    public static var red: Color {
        return Color(r: 1, g: 0, b: 0, a: 1)
    }
    
    public static var green: Color {
        return Color(r: 0, g: 1, b: 0, a: 1)
    }
    
    public static var blue: Color {
        return Color(r: 0, g: 0, b: 1, a: 1)
    }
    
    public static var cyan: Color {
        return Color(r: 0, g: 1, b: 1, a: 1)
    }
    
    public static var magenta: Color {
        return Color(r: 1, g: 0, b: 1, a: 1)
    }
    
    public static var yellow: Color {
        return Color(r: 1, g: 1, b: 0, a: 1)
    }
    
    public static var transparent: Color {
        return Color(r: 0, g: 0, b: 0, a: 0)
    }
}

// MARK: - Utility

extension Color where P: RGBWithAlpha {
    private static func createColor(r: T, g: T, b: T, a: T) -> Color {
        switch P.colorStartIndex {
        case 0: // RGBA
            return Color(data: [r, g, b, a])
        case 1: // ARGB
            return Color(data: [a, r, g, b])
        default:
            fatalError("Never happens.")
        }
    }
}
