public protocol DataType: Equatable {
    static var swimDefaultValue: Self { get }
}

extension Bool: DataType {
    public static var swimDefaultValue: Bool = true
}

extension DataType where Self: AdditiveArithmetic {
    @inlinable
    public static var swimDefaultValue: Self {
        return .zero
    }
}

extension UInt8: DataType {}
extension Int: DataType {}
extension Float: DataType {}
extension Double: DataType {}
