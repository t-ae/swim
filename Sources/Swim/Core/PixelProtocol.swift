public protocol PixelProtocol {
    associatedtype P: PixelType
    associatedtype T: DataType
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R
}

public protocol MutablePixelProtocol: PixelProtocol, MutableDataContainer {
}

extension Pixel: MutablePixelProtocol {
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return data.withUnsafeBufferPointer(body)
    }
    
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>)->R) -> R {
        return data.withUnsafeMutableBufferPointer { bp in
            body(bp)
        }
    }
}

extension PixelRef: PixelProtocol {
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(pointer)
    }
}

extension MutablePixelRef: MutablePixelProtocol {
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>)->R) -> R {
        return body(UnsafeBufferPointer(pointer))
    }
    
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>)->R) -> R {
        return body(pointer)
    }
}

extension PixelProtocol {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            return withUnsafeBufferPointer {
                return $0[channel]
            }
        }
    }
    
    @inlinable
    public subscript(channel: P) -> T {
        get {
            return self[channel.rawValue]
        }
    }
}

extension MutablePixelProtocol {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            return withUnsafeBufferPointer {
                return $0[channel]
            }
        }
        set {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            withUnsafeMutableBufferPointer {
                $0[channel] = newValue
            }
        }
    }
    
    @inlinable
    public subscript(channel: P) -> T {
        get {
            return self[channel.rawValue]
        }
        set {
            self[channel.rawValue] = newValue
        }
    }
}
