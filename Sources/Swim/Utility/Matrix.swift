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
    
    public init(rows: Int, cols: Int, full value: T) {
        self.init(rows: rows, cols: cols, data: [T](repeating: value, count: rows*cols))
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
    public func transposed() -> Matrix {
        var matrix = Matrix(rows: cols, cols: rows, data: data)
        
        for i in 0..<rows {
            for j in 0..<cols {
                matrix[j, i] = self[i, j]
            }
        }
        
        return matrix
    }
}

extension Matrix where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Matrix, rhs: Matrix) {
        precondition(lhs.rows == rhs.rows, "rows not match")
        precondition(lhs.cols == rhs.cols, "cols not match")
        
        for i in 0..<lhs.data.count {
            lhs.data[i] += rhs.data[i]
        }
    }
    
    @inlinable
    public static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.rows == rhs.rows, "rows not match")
        precondition(lhs.cols == rhs.cols, "cols not match")
        
        return Matrix(rows: lhs.rows, cols: lhs.cols, data: zip(lhs.data, rhs.data).map { $0 + $1 })
    }
    
    @inlinable
    public static func -=(lhs: inout Matrix, rhs: Matrix) {
        precondition(lhs.rows == rhs.rows, "rows not match")
        precondition(lhs.cols == rhs.cols, "cols not match")
        
        for i in 0..<lhs.data.count {
            lhs.data[i] -= rhs.data[i]
        }
    }
    
    @inlinable
    public static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.rows == rhs.rows, "rows not match")
        precondition(lhs.cols == rhs.cols, "cols not match")
        
        return Matrix(rows: lhs.rows, cols: lhs.cols, data: zip(lhs.data, rhs.data).map { $0 - $1 })
    }
}

extension Matrix where T: Numeric {
    @inlinable
    public static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.cols == rhs.rows, "Can't multiply matrices.")
        
        var matrix = Matrix(rows: lhs.rows, cols: rhs.cols, full: 0)
        
        for i in 0..<lhs.rows {
            for j in 0..<lhs.cols {
                for k in 0..<rhs.cols {
                    matrix[i, k] += lhs[i, j] * rhs[j, k]
                }
            }
        }
        
        return matrix
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
