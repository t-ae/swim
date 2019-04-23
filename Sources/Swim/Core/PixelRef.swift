import Foundation

public struct PixelRef<P: PixelType, T: DataType> {
    public internal(set) var x: Int
    public internal(set) var y: Int
    var pointer: UnsafeBufferPointer<T>
    
    init(x: Int, y: Int, pointer: UnsafeBufferPointer<T>) {
        self.x = x
        self.y = y
        self.pointer = pointer
    }
}

public struct MutablePixelRef<P: PixelType, T: DataType> {
    public internal(set) var x: Int
    public internal(set) var y: Int
    var pointer: UnsafeMutableBufferPointer<T>
    
    init(x: Int, y: Int, pointer: UnsafeMutableBufferPointer<T>) {
        self.x = x
        self.y = y
        self.pointer = pointer
    }
}

