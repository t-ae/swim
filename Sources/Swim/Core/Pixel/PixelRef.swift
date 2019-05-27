// MARK: - PixelRef
public struct PixelRef<P: PixelType, T: DataType> {
    public let x: Int
    public let y: Int
    
    @usableFromInline
    let pointer: UnsafeBufferPointer<T>
    
    @inlinable
    init(x: Int, y: Int, pointer: UnsafeBufferPointer<T>) {
        assert(pointer.count == P.channels)
        self.x = x
        self.y = y
        self.pointer = pointer
    }
    
    @inlinable
    init(x: Int, y: Int, rebasing slice: Slice<UnsafeBufferPointer<T>>) {
        self.init(x: x, y: y, pointer: UnsafeBufferPointer(rebasing: slice))
    }
}

extension PixelRef {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
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
    public let x: Int
    public let y: Int
    
    @usableFromInline
    let pointer: UnsafeMutableBufferPointer<T>
    
    @inlinable
    init(x: Int, y: Int, pointer: UnsafeMutableBufferPointer<T>) {
        assert(pointer.count == P.channels)
        self.x = x
        self.y = y
        self.pointer = pointer
    }
    
    @inlinable
    init(x: Int, y: Int, rebasing slice: Slice<UnsafeMutableBufferPointer<T>>) {
        self.init(x: x, y: y, pointer: UnsafeMutableBufferPointer(rebasing: slice))
    }
}

extension MutablePixelRef {
    @inlinable
    public subscript(channel: Int) -> T {
        get {
            return pointer[channel]
        }
        nonmutating set {
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
    /// Create `PixelRef` pointing specified coord and execute `body`.
    ///
    /// For raster iteration, using `iteratePixels` is faster.
    @inlinable
    public func withPixelRef<R>(x: Int, y: Int, _ body: (PixelRef<P, T>)->R) -> R {
        let start = dataIndex(x: x, y: y)
        return data.withUnsafeBufferPointer {
            let bp = UnsafeBufferPointer(rebasing: $0[start..<start+P.channels])
            let ref = PixelRef<P, T>(x: x, y: y, pointer: bp)
            return body(ref)
        }
    }
    
    /// Create `MutablePixelRef` pointing specified coord and execute `body`.
    ///
    /// For raster iteration, using `pixelwiseConvert` is faster.
    @inlinable
    public mutating func withMutablePixelRef<R>(x: Int, y: Int, _ body: (MutablePixelRef<P, T>)->R) -> R {
        let start = dataIndex(x: x, y: y)
        return data.withUnsafeMutableBufferPointer {
            let bp = UnsafeMutableBufferPointer(rebasing: $0[start..<start+P.channels])
            let ref = MutablePixelRef<P, T>(x: x, y: y, pointer: bp)
            return body(ref)
        }
    }
}
