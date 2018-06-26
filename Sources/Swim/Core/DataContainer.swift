import Foundation

public protocol DataContainer {
    associatedtype PT: PixelType
    associatedtype DT: DataType
    
    var data: [DT] { get set }
}

extension Image: DataContainer {
    public typealias PT = P
    public typealias DT = T
}

extension Pixel: DataContainer {
    public typealias PT = P
    public typealias DT = T
}
