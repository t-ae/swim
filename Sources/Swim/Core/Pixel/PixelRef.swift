/// Reference to pixel in image.
///
/// It contains `UnsafeMutableBufferPointer` which pointing images buffer.
/// `PixelRef` is created only inside `withUnsafeMutableBufferPointer`'s body.
/// Since `withUnsafeMutableBufferPointer` 's argument is valid only for the duration of the method’s execution, `PixelRef` is also valid only for the duration of the methods' execution.
///
/// Usages:
/// - `Image<P, T>.createWithPixelRef`
/// - `Image<P, T>.withPixelRef`
/// - `Image<P, T>.pixelwiseConvert`
/// - `Image<P, T>.pixelwiseConverted`
public struct PixelRef<P: PixelType, T: DataType> {
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

extension PixelRef {
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
    /// For raster iteration, using `pixels()` or `pixelwiseConvert(_:)` is better.
    @inlinable
    public mutating func withPixelRef<R>(x: Int, y: Int, _ body: (PixelRef<P, T>)->R) -> R {
        let start = dataIndex(x: x, y: y)
        return data.withUnsafeMutableBufferPointer {
            let bp = UnsafeMutableBufferPointer(rebasing: $0[start..<start+P.channels])
            let ref = PixelRef<P, T>(x: x, y: y, pointer: bp)
            return body(ref)
        }
    }
}
