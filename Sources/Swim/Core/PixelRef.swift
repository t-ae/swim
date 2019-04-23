public struct PixelRef<P: PixelType, T: DataType> {
    @usableFromInline
    var _x: Int
    @usableFromInline
    var _y: Int
    @usableFromInline
    var pointer: UnsafeBufferPointer<T>
    
    @inlinable
    init(_x: Int, _y: Int, pointer: UnsafeBufferPointer<T>) {
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

public struct MutablePixelRef<P: PixelType, T: DataType> {
    @usableFromInline
    var _x: Int
    @usableFromInline
    var _y: Int
    @usableFromInline
    var pointer: UnsafeMutableBufferPointer<T>
    
    @inlinable
    init(_x: Int, _y: Int, pointer: UnsafeMutableBufferPointer<T>) {
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
