// MARK: - PixelType
public protocol PixelType {
    static var channels: Int { get }
    
    init?(rawValue: Int)
    var rawValue: Int { get }
}

public enum Intensity: Int, PixelType, CaseIterable {
    public static var channels: Int = 1
    
    case intensity = 0
}

public enum IntensityAlpha: Int, PixelType, CaseIterable {
    public static var channels: Int = 2
    
    case intensity = 0
    case alpha = 1
}

public enum RGB: Int, PixelType, CaseIterable {
    public static var channels: Int = 3
    
    case red = 0
    case green = 1
    case blue = 2
}

public enum RGBA: Int, PixelType, CaseIterable {
    public static var channels: Int = 4
    
    case red = 0
    case green = 1
    case blue = 2
    case alpha = 3
}

public enum ARGB: Int, PixelType, CaseIterable {
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
    @inlinable
    public static var greenIndex: Int { return Self.redIndex + 1 }
    
    @inlinable
    public static var blueIndex: Int { return Self.redIndex + 2 }
    
    @inlinable
    public static var alphaIndex: Int { return (Self.redIndex + 3) % 4 }
}
extension RGBA: RGBWithAlpha {
    public static let redIndex: Int = RGBA.red.rawValue
}
extension ARGB: RGBWithAlpha {
    public static let redIndex: Int = ARGB.red.rawValue
}
