public protocol HomogeneousTransformationMatrix {
    func inverted() throws -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: (x: Double, y: Double)) -> (x: Double, y: Double)
}

// MARK: - Error

public enum MatrixInversionError: Error {
    case singularMatrix
}
