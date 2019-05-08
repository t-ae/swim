// MARK: - HomogeneousTransformationMatrixProtocol

public protocol HomogeneousTransformationMatrixProtocol {
    @inlinable func inverted() throws -> Self
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
        
        return HomogeneousTransformationMatrix(elements: [e00, e01, e02,
                                                          e10, e11, e12,
                                                          e20, e21, e22].map { $0/det })
    }
}

extension HomogeneousTransformationMatrix {
    public var identity: HomogeneousTransformationMatrix {
        return .init(elements: [1, 0, 0, 0, 1, 0, 0, 0, 1])
    }
}

extension HomogeneousTransformationMatrix {
    public static func project(from: ((Double, Double), (Double, Double), (Double, Double), (Double, Double)),
                               to: ((Double, Double), (Double, Double), (Double, Double), (Double, Double))) throws -> HomogeneousTransformationMatrix {
        // a: (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1) to `from`
        let a: HomogeneousTransformationMatrix
        do {
            let mat = HomogeneousTransformationMatrix(elements: [from.0.0, from.1.0, from.2.0,
                                                                 from.0.1, from.1.1, from.2.1,
                                                                 1, 1, 1])
            let inv = try mat.inverted().elements
            let coef0 = inv[0]*from.3.0 + inv[1]*from.3.1 + inv[2]
            let coef1 = inv[3]*from.3.0 + inv[4]*from.3.1 + inv[5]
            let coef2 = inv[6]*from.3.0 + inv[7]*from.3.1 + inv[8]
            
            a = HomogeneousTransformationMatrix(elements: [
                coef0*from.0.0, coef1*from.1.0, coef2*from.2.0,
                coef0*from.0.1, coef1*from.1.1, coef2*from.2.1,
                coef0, coef1, coef2])
        }
        // b: (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1) to `to`
        let b: HomogeneousTransformationMatrix
        do {
            let mat = HomogeneousTransformationMatrix(elements: [to.0.0, to.1.0, to.2.0,
                                                                 to.0.1, to.1.1, to.2.1,
                                                                 1, 1, 1])
            let inv = try mat.inverted().elements
            let coef0 = inv[0]*to.3.0 + inv[1]*to.3.1 + inv[2]
            let coef1 = inv[3]*to.3.0 + inv[4]*to.3.1 + inv[5]
            let coef2 = inv[6]*to.3.0 + inv[7]*to.3.1 + inv[8]
            
            b = HomogeneousTransformationMatrix(elements: [
                coef0*to.0.0, coef1*to.1.0, coef2*to.2.0,
                coef0*to.0.1, coef1*to.1.1, coef2*to.2.1,
                coef0, coef1, coef2])
        }
        
        // a.inverted: `from` to (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1)
        return try b * a.inverted()
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
