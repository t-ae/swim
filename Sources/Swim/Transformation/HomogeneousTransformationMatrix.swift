// MARK: - HomogeneousTransformationMatrixProtocol

public protocol HomogeneousTransformationMatrixProtocol {
    associatedtype InvertedMatrix: HomogeneousTransformationMatrixProtocol
    @inlinable func inverted() throws -> InvertedMatrix
    @inlinable static func *(lhs: Self, rhs: (x: Double, y: Double)) -> (x: Double, y: Double)
}

// MARK: - HomogeneousTransformationMatrix

public struct HomogeneousTransformationMatrix: HomogeneousTransformationMatrixProtocol {
    public var elements: [Double]
    
    public init(elements: [Double]) {
        precondition(elements.count == 9, "HomogeneousTransformationMatrix must have 9 elements.")
        self.elements = elements
    }
    
    @inlinable
    public var determinant: Double {
        let e = elements
        var det: Double = 0
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
        
        let e00: Double = e[4]*e[8] - e[5]*e[7]
        let e01: Double = e[2]*e[7] - e[1]*e[8]
        let e02: Double = e[1]*e[5] - e[2]*e[4]
        let e10: Double = e[5]*e[6] - e[3]*e[8]
        let e11: Double = e[0]*e[8] - e[2]*e[6]
        let e12: Double = e[2]*e[3] - e[0]*e[5]
        let e20: Double = e[3]*e[7] - e[4]*e[6]
        let e21: Double = e[1]*e[6] - e[0]*e[7]
        let e22: Double = e[0]*e[4] - e[1]*e[3]
        
        return HomogeneousTransformationMatrix(elements: [e00 / det, e01 / det, e02 / det,
                                                          e10 / det, e11 / det, e12 / det,
                                                          e20 / det, e21 / det, e22 / det])
    }
}

extension HomogeneousTransformationMatrix {
    public var identity: HomogeneousTransformationMatrix {
        return .init(elements: [1, 0, 0, 0, 1, 0, 0, 0, 1])
    }
}

public func *(lhs: HomogeneousTransformationMatrix,
              rhs: HomogeneousTransformationMatrix) -> HomogeneousTransformationMatrix {
    let elements = matmul(lhs: lhs.elements, rhs: rhs.elements, m: 3, n: 3, p: 3)
    return HomogeneousTransformationMatrix(elements: elements)
}

public func *(lhs: HomogeneousTransformationMatrix,
              rhs: (x: Double, y: Double)) -> (x: Double, y: Double) {
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
