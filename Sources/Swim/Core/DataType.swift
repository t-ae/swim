
public protocol DataType: Equatable {
    static var swimDefaultValue: Self { get }
}

extension Bool: DataType {
    public static var swimDefaultValue: Bool = true
}

extension UInt8: DataType {
    public static var swimDefaultValue: UInt8 = 0
}

extension Int: DataType {
    public static var swimDefaultValue: Int = 0
}

extension Float: DataType {
    public static var swimDefaultValue: Float = 0
}

extension Double: DataType {
    public static var swimDefaultValue: Double = 0
}
