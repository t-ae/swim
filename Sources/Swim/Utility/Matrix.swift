public struct Matrix<T> {
    public let rows: Int
    public let cols: Int
    
    @usableFromInline
    var data: [T]
    
    public init(rows: Int, cols: Int, data: [T]) {
        precondition(data.count == rows*cols, "data.count must be equal to width*height.")
        self.rows = rows
        self.cols = cols
        self.data = data
    }
    
    public subscript(row: Int, col: Int) -> T {
        get {
            precondition(0 <= row && row < rows, "row out of range.")
            precondition(0 <= col && col < cols, "col out of range.")
            return data[row * cols + col]
        }
        set {
            precondition(0 <= row && row < rows, "row out of range.")
            precondition(0 <= col && col < cols, "col out of range.")
            data[row * cols + col] = newValue
        }
    }
}

extension Matrix {
    @inlinable
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<T>) -> R) -> R {
        return data.withUnsafeBufferPointer(body)
    }
    
    @inlinable
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (UnsafeMutableBufferPointer<T>) -> R) -> R {
        return data.withUnsafeMutableBufferPointer { bp in
            body(bp)
        }
    }
}


extension Matrix: Equatable where T: Equatable {}
