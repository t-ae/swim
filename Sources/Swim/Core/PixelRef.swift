// MARK: - PixelRef
public struct PixelRef<P: PixelType, T: DataType> {
    @usableFromInline
    var _x: Int
    @usableFromInline
    var _y: Int
    @usableFromInline
    var pointer: UnsafeBufferPointer<T>
    
    @inlinable
    init(_x: Int, _y: Int, pointer: UnsafeBufferPointer<T>) {
        assert(pointer.count == P.channels)
        self._x = _x
        self._y = _y
        self.pointer = pointer
    }
    
    public var x: Int { return _x }
    public var y: Int { return _y }
}

extension PixelRef {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            return pointer[channel]
        }
    }
    
    @inlinable
    public subscript(channel: P) -> T {
        get {
            return self[channel.rawValue]
        }
    }
}

// MARK: - MutablePixelRef
public struct MutablePixelRef<P: PixelType, T: DataType> {
    @usableFromInline
    var _x: Int
    @usableFromInline
    var _y: Int
    @usableFromInline
    var pointer: UnsafeMutableBufferPointer<T>
    
    @inlinable
    init(_x: Int, _y: Int, pointer: UnsafeMutableBufferPointer<T>) {
        assert(pointer.count == P.channels)
        self._x = _x
        self._y = _y
        self.pointer = pointer
    }
    
    public var x: Int { return _x }
    public var y: Int { return _y }
}

extension MutablePixelRef {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            return pointer[channel]
        }
        nonmutating set {
            precondition(0 <= channel && channel < P.channels, "Index out of range.")
            pointer[channel] = newValue
        }
    }
    
    @inlinable
    public subscript(channel: P) -> T {
        get {
            return self[channel.rawValue]
        }
        nonmutating set {
            self[channel.rawValue] = newValue
        }
    }
}

// MARK: - Image extension
extension Image {
    @inlinable
    public func withPixelRef<R>(x: Int, y: Int, _ body: (PixelRef<P, T>)->R) -> R {
        return data.withUnsafeBufferPointer {
            let start = (y*width + x) * P.channels
            let bp = UnsafeBufferPointer(rebasing: $0[start..<start+P.channels])
            let ref = PixelRef<P, T>(_x: x, _y: y, pointer: bp)
            return body(ref)
        }
    }
    
    @inlinable
    public mutating func withMutablePixelRef<R>(x: Int, y: Int, _ body: (MutablePixelRef<P, T>)->R) -> R {
        let width = self.width
        return data.withUnsafeMutableBufferPointer {
            let start = (y*width + x) * P.channels
            let bp = UnsafeMutableBufferPointer(rebasing: $0[start..<start+P.channels])
            let ref = MutablePixelRef<P, T>(_x: x, _y: y, pointer: bp)
            return body(ref)
        }
    }
}
