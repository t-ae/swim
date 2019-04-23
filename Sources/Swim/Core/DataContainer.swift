import Foundation

public protocol DataContainer {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    var data: [T] { get set }
}

extension Image: DataContainer {
}

extension Pixel: DataContainer {
}

public protocol MutableDataContainer {
    associatedtype T
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>)->R) -> R
}

extension Image: MutableDataContainer {
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>) -> R) -> R {
        return data.withUnsafeMutableBufferPointer { bp in body (bp) }
    }
}
