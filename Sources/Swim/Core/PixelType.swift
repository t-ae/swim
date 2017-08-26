
public protocol PixelType {
    static var channels: Int { get }
    
    init?(rawValue: Int)
    var rawValue: Int { get }
}

public enum Intensity: Int, PixelType {
    public static var channels: Int = 1
    
    case intensity = 0
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
