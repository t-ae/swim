public protocol ColorProtocol {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R
    
    subscript(channel: Int) -> T { get }
    subscript(channel: P) -> T { get }
}

extension Color: ColorProtocol {
    @inlinable
    public init<C: ColorProtocol>(from color: C) where C.P == P, C.T == T {
        self.init(data: color.withUnsafeBufferPointer(Array.init))
    }
    
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) -> R) -> R {
        return data.withUnsafeBufferPointer(body)
    }
}

extension Pixel: ColorProtocol {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) -> R) -> R {
        return color.withUnsafeBufferPointer(body)
    }
}

extension PixelRef: ColorProtocol {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(pointer)
    }
}

extension MutablePixelRef: ColorProtocol {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(UnsafeBufferPointer(pointer))
    }
}
