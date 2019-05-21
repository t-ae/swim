// MARK: - PixelType
public protocol PixelType: RawRepresentable {
    static var channels: Int { get }
    
    init?(rawValue: Int)
    var rawValue: Int { get }
}

public enum Gray: Int, PixelType, CaseIterable {
    public static let channels: Int = 1
    
    case gray = 0
}

public enum GrayAlpha: Int, PixelType, CaseIterable {
    public static let channels: Int = 2
    
    case gray = 0
    case alpha = 1
}

public enum RGB: Int, PixelType, CaseIterable {
    public static let channels: Int = 3
    
    case red = 0
    case green = 1
    case blue = 2
}

public enum RGBA: Int, PixelType, CaseIterable {
    public static let channels: Int = 4
    
    case red = 0
    case green = 1
    case blue = 2
    case alpha = 3
}

public enum ARGB: Int, PixelType, CaseIterable {
    public static let channels: Int = 4
    
    case alpha = 0
    case red = 1
    case green = 2
    case blue = 3
}

// MARK: - HasAlpha
public protocol HasAlpha {
    associatedtype BaseType: PixelType
    static var colorStartIndex: Int { get }
    static var alphaIndex: Int { get }
}

extension GrayAlpha: HasAlpha {
    public typealias BaseType = Gray
    public static let colorStartIndex: Int = 0
    public static let alphaIndex: Int = 1
}

// MARK: - RGBWithAlpha
public protocol RGBWithAlpha: PixelType, HasAlpha {
    static var redIndex: Int { get }
    static var greenIndex: Int { get }
    static var blueIndex: Int { get }
}

extension RGBA: RGBWithAlpha {
    public typealias BaseType = RGB
    public static let redIndex: Int = RGBA.red.rawValue
    public static let greenIndex: Int = RGBA.green.rawValue
    public static let blueIndex: Int = RGBA.blue.rawValue
    
    public static let colorStartIndex: Int = RGBA.red.rawValue
    public static let alphaIndex: Int = RGBA.alpha.rawValue
}

extension ARGB: RGBWithAlpha {
    public typealias BaseType = RGB
    public static let redIndex: Int = ARGB.red.rawValue
    public static let greenIndex: Int = ARGB.green.rawValue
    public static let blueIndex: Int = ARGB.blue.rawValue
    
    public static let colorStartIndex: Int = ARGB.red.rawValue
    public static let alphaIndex: Int = ARGB.alpha.rawValue
}
