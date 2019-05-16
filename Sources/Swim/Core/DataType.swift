public protocol DataType {
    // TODO: We need it because currently there's no way to create Array with uninitialized buffer.
    // That feature will be introduced in Swift5.1. Then this propery will be removed.
    // https://github.com/apple/swift-evolution/blob/master/proposals/0245-array-uninitialized-initializer.md
    static var swimDefaultValue: Self { get }
}

extension Bool: DataType {
    public static let swimDefaultValue: Bool = true
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
