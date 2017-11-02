
import Foundation

public protocol DataContainer {
    associatedtype PT: PixelType
    associatedtype DT: DataType
    
    var count: Int { get }
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<DT>) throws -> R) rethrows -> R
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<DT>) throws -> R) rethrows -> R
}

extension Image: DataContainer {
    
    public typealias PT = P
    public typealias DT = T
    
    public var count: Int {
        return data.count
    }
    
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) throws -> R) rethrows -> R {
        return try data.withUnsafeBufferPointer(body)
    }
    
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<T>) throws -> R) rethrows -> R {
        return try data.withUnsafeMutableBufferPointer(body)
    }
    
}

extension Pixel: DataContainer {
    public typealias PT = P
    public typealias DT = T
    
    public var count: Int {
        return data.count
    }
    
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) throws -> R) rethrows -> R {
        return try data.withUnsafeBufferPointer(body)
    }
    
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<T>) throws -> R) rethrows -> R{
        return try data.withUnsafeMutableBufferPointer(body)
    }
}
