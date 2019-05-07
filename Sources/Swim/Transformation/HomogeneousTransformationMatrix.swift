// MARK: - HomogeneousTransformationMatrixProtocol

public protocol HomogeneousTransformationMatrixProtocol {
    associatedtype T: BinaryFloatingPoint
    associatedtype InvertedMatrix: HomogeneousTransformationMatrixProtocol where InvertedMatrix.T == T
    @inlinable func inverted() throws -> InvertedMatrix
    @inlinable static func *(lhs: Self, rhs: (x: T, y: T)) -> (x: T, y: T)
}

// MARK: - HomogeneousTransformationMatrix

public struct HomogeneousTransformationMatrix<T: BinaryFloatingPoint>: HomogeneousTransformationMatrixProtocol {
    public var elements: [T]
    
    public init(elements: [T]) {
        precondition(elements.count == 9, "HomogeneousTransformationMatrix must have 9 elements.")
        self.elements = elements
    }
    
    @inlinable
    public var determinant: T {
        let e = elements
        var det: T = 0
        det += e[0]*e[4]*e[8]
        det += e[1]*e[5]*e[6]
        det += e[2]*e[3]*e[7]
        det -= e[0]*e[5]*e[7]
        det -= e[1]*e[3]*e[8]
        det -= e[2]*e[4]*e[6]
        return det
    }
    
    @inlinable
    public func inverted() throws -> HomogeneousTransformationMatrix {
        let e = elements
        let det = determinant
        
        guard determinant != 0 else {
            throw MatrixInversionError.singularMatrix
        }
        
        let e00: T = e[4]*e[8] - e[5]*e[7]
        let e01: T = e[2]*e[7] - e[1]*e[8]
        let e02: T = e[1]*e[5] - e[2]*e[4]
        let e10: T = e[5]*e[6] - e[3]*e[8]
        let e11: T = e[0]*e[8] - e[2]*e[6]
        let e12: T = e[2]*e[3] - e[0]*e[5]
        let e20: T = e[3]*e[7] - e[4]*e[6]
        let e21: T = e[1]*e[6] - e[0]*e[7]
        let e22: T = e[0]*e[4] - e[1]*e[3]
        
        return HomogeneousTransformationMatrix(elements: [e00 / det, e01 / det, e02 / det,
                                                          e10 / det, e11 / det, e12 / det,
                                                          e20 / det, e21 / det, e22 / det])
    }
}

extension HomogeneousTransformationMatrix {
    public var identity: HomogeneousTransformationMatrix<T> {
        return .init(elements: [1, 0, 0, 0, 1, 0, 0, 0, 1])
    }
}

public func *<T: BinaryFloatingPoint>(lhs: HomogeneousTransformationMatrix<T>,
                                      rhs: HomogeneousTransformationMatrix<T>) -> HomogeneousTransformationMatrix<T> {
    let elements = matmul(lhs: lhs.elements, rhs: rhs.elements, m: 3, n: 3, p: 3)
    return HomogeneousTransformationMatrix(elements: elements)
}

public func *<T: BinaryFloatingPoint>(lhs: HomogeneousTransformationMatrix<T>,
                                      rhs: (x: T, y: T)) -> (x: T, y: T) {
    let e = lhs.elements
    let x = e[0]*rhs.0 + e[1]*rhs.1 + e[2]
    let y = e[3]*rhs.0 + e[4]*rhs.1 + e[5]
    let w = e[6]*rhs.0 + e[7]*rhs.1 + e[8]
    return (x / w, y / w)
}

// MARK: - Error

public enum MatrixInversionError: Error {
    case singularMatrix
}
