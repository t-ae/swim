public protocol PixelProtocol {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R
    
    subscript(channel: Int) -> T { get }
    subscript(channel: P) -> T { get }
}

extension Pixel: PixelProtocol {
}

extension PixelRef: PixelProtocol {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(pointer)
    }
}

extension MutablePixelRef: PixelProtocol {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(UnsafeBufferPointer(pointer))
    }
}
