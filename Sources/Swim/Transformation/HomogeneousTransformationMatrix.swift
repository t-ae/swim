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
    public static func project(source: ((x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double)),
                               target: ((x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double))) throws -> HomogeneousTransformationMatrix {
        // a: (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1) to `source`
        let a: HomogeneousTransformationMatrix
        do {
            let mat = HomogeneousTransformationMatrix(elements: [source.0.x, source.1.x, source.2.x,
                                                                 source.0.y, source.1.y, source.2.y,
                                                                 1, 1, 1])
            let inv = try mat.inverted().elements
            let coef0 = inv[0]*source.3.x + inv[1]*source.3.y + inv[2]
            let coef1 = inv[3]*source.3.x + inv[4]*source.3.y + inv[5]
            let coef2 = inv[6]*source.3.x + inv[7]*source.3.y + inv[8]
            
            a = HomogeneousTransformationMatrix(elements: [
                coef0*source.0.x, coef1*source.1.x, coef2*source.2.x,
                coef0*source.0.y, coef1*source.1.y, coef2*source.2.y,
                coef0, coef1, coef2])
        }
        // b: (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1) to `target`
        let b: HomogeneousTransformationMatrix
        do {
            let mat = HomogeneousTransformationMatrix(elements: [target.0.x, target.1.x, target.2.x,
                                                                 target.0.y, target.1.y, target.2.y,
                                                                 1, 1, 1])
            let inv = try mat.inverted().elements
            let coef0 = inv[0]*target.3.x + inv[1]*target.3.y + inv[2]
            let coef1 = inv[3]*target.3.x + inv[4]*target.3.y + inv[5]
            let coef2 = inv[6]*target.3.x + inv[7]*target.3.y + inv[8]
            
            b = HomogeneousTransformationMatrix(elements: [
                coef0*target.0.x, coef1*target.1.x, coef2*target.2.x,
                coef0*target.0.y, coef1*target.1.y, coef2*target.2.y,
                coef0, coef1, coef2])
        }
        
        // a.inverted: `source` to (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1)
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
    let x = e[0]*rhs.x + e[1]*rhs.y + e[2]
    let y = e[3]*rhs.x + e[4]*rhs.y + e[5]
    let w = e[6]*rhs.x + e[7]*rhs.y + e[8]
    return (x / w, y / w)
}

// MARK: - Error

public enum MatrixInversionError: Error {
    case singularMatrix
}
