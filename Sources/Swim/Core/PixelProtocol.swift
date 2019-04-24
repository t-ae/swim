public protocol PixelProtocol {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    @inlinable
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R
    
    @inlinable
    subscript(channel: Int) -> T { get }
    
    @inlinable
    subscript(channel: P) -> T { get }
}

extension Pixel: PixelProtocol {
}

extension PixelRef: PixelProtocol {
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(pointer)
    }
}

extension MutablePixelRef: PixelProtocol {
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(UnsafeBufferPointer(pointer))
    }
}
