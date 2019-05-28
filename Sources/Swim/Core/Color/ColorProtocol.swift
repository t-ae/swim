public protocol ColorProtocol {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R
    
    subscript(channel: Int) -> T { get }
    subscript(channel: P) -> T { get }
}

extension Pixel: ColorProtocol {
    @inlinable
    public init<Px: ColorProtocol>(from pixel: Px) where Px.P == P, Px.T == T {
        self.init(data: pixel.withUnsafeBufferPointer(Array.init))
    }
    
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) -> R) -> R {
        return data.withUnsafeBufferPointer(body)
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
