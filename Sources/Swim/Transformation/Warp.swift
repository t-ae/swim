public enum MatrixInversionError: Error {
    case singularMatrix
}

public struct HomogeneousTransformationMatrix<T: BinaryFloatingPoint> {
    public var elements: [T]
    
    public init(elements: [T]) {
        precondition(elements.count == 9, "HomogeneousTransformationMatrix must have 9 elements.")
        self.elements = elements
    }
    
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

public func *<T: BinaryFloatingPoint>(lhs: HomogeneousTransformationMatrix<T>,
                                      rhs: HomogeneousTransformationMatrix<T>) -> HomogeneousTransformationMatrix<T> {
    let elements = matmul(lhs: lhs.elements, rhs: rhs.elements, m: 3, n: 3, p: 3)
    return HomogeneousTransformationMatrix(elements: elements)
}
