public protocol PixelProtocol {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R
    
    subscript(channel: Int) -> T { get }
    subscript(channel: P) -> T { get }
}

extension Pixel: PixelProtocol {
    @inlinable
    public init<Px: PixelProtocol>(from pixel: Px) where Px.P == P, Px.T == T {
        self.init(data: pixel.withUnsafeBufferPointer(Array.init))
    }
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
