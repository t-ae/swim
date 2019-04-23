import Foundation

public protocol MutableDataContainer {
    associatedtype T
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>)->R) -> R
}

extension Image: MutableDataContainer {
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>) -> R) -> R {
        return data.withUnsafeMutableBufferPointer { bp in body (bp) }
    }
}

extension Pixel: MutableDataContainer {
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>) -> R) -> R {
        return data.withUnsafeMutableBufferPointer { bp in body (bp) }
    }
}
