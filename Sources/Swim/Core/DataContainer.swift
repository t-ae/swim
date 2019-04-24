import Foundation

public protocol MutableDataContainer {
    associatedtype T
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>)->R) -> R
}

extension Image: MutableDataContainer {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) -> R) -> R {
        return data.withUnsafeBufferPointer(body)
    }
    
    @inlinable
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>) -> R) -> R {
        return data.withUnsafeMutableBufferPointer { body($0) }
    }
}

extension Pixel: MutableDataContainer {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) -> R) -> R {
        return data.withUnsafeBufferPointer(body)
    }
    
    @inlinable
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>) -> R) -> R {
        return data.withUnsafeMutableBufferPointer { bp in body (bp) }
    }
}
