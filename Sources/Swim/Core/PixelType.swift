// MARK: - PixelType
public protocol PixelType {
    static var channels: Int { get }
    
    init?(rawValue: Int)
    var rawValue: Int { get }
}

public enum Intensity: Int, PixelType {
    public static var channels: Int = 1
    
    case intensity = 0
}

public enum IntensityAlpha: Int, PixelType {
    public static var channels: Int = 2
    
    case intensity = 0
    case alpha = 1
}

public enum RGB: Int, PixelType {
    public static var channels: Int = 3
    
    case red = 0
    case green = 1
    case blue = 2
}

public enum RGBA: Int, PixelType {
    public static var channels: Int = 4
    
    case red = 0
    case green = 1
    case blue = 2
    case alpha = 3
}

public enum ARGB: Int, PixelType {
    public static var channels: Int = 4
    
    case alpha = 0
    case red = 1
    case green = 2
    case blue = 3
}


// MARK: - RGBWithAlpha
public protocol RGBWithAlpha: PixelType {
    static var redIndex: Int { get }
    static var greenIndex: Int { get }
    static var blueIndex: Int { get }
    static var alphaIndex: Int { get }
}
extension RGBWithAlpha {
    public static var greenIndex: Int { return Self.alphaIndex + 1 }
    public static var blueIndex: Int { return Self.alphaIndex + 2 }
    public static var alphaIndex: Int { return (Self.alphaIndex + 3) % 4 }
}
extension RGBA: RGBWithAlpha {
    public static let redIndex: Int = RGBA.red.rawValue
}
extension ARGB: RGBWithAlpha {
    public static let redIndex: Int = ARGB.red.rawValue
}
