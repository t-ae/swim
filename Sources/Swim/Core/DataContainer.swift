
import Foundation

public protocol DataContainer {
    associatedtype PT: PixelType
    associatedtype DT: DataType
    
    // get-only to make deta internal(set)
    var data: [DT] { get }
    
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<DT>) throws -> R) rethrows -> R
}

extension DataContainer {
    public var count: Int {
        return data.count
    }
    
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<DT>) throws -> R) rethrows -> R {
        return try data.withUnsafeBufferPointer(body)
    }
}

extension Image: DataContainer {
    public typealias PT = P
    public typealias DT = T
    
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<T>) throws -> R) rethrows -> R {
        return try data.withUnsafeMutableBufferPointer(body)
    }
}

extension Pixel: DataContainer {
    public typealias PT = P
    public typealias DT = T
    
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<T>) throws -> R) rethrows -> R{
        return try data.withUnsafeMutableBufferPointer(body)
    }
}
