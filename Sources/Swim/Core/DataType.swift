
public protocol DataType: Equatable, ExpressibleByIntegerLiteral {
    
}

extension UInt8: DataType {}
extension Int: DataType {}
extension Float: DataType {}
extension Double: DataType {}
