// MARK: - HomogeneousTransformationMatrixProtocol

public protocol HomogeneousTransformationMatrixProtocol {
    @inlinable func inverted() throws -> Self
    @inlinable static func *(lhs: Self, rhs: (x: Double, y: Double)) -> (x: Double, y: Double)
}

// MARK: - HomogeneousTransformationMatrix

public struct HomogeneousTransformationMatrix: HomogeneousTransformationMatrixProtocol {
    public var e00: Double
    public var e01: Double
    public var e02: Double
    public var e10: Double
    public var e11: Double
    public var e12: Double
    public var e20: Double
    public var e21: Double
    public var e22: Double
    
    public init(_ e00: Double, _ e01: Double, _ e02: Double,
                _ e10: Double, _ e11: Double, _ e12: Double,
                _ e20: Double, _ e21: Double, _ e22: Double) {
        self.e00 = e00
        self.e01 = e01
        self.e02 = e02
        self.e10 = e10
        self.e11 = e11
        self.e12 = e12
        self.e20 = e20
        self.e21 = e21
        self.e22 = e22
    }
    
    @inlinable
    public var determinant: Double {
        var det: Double = 0
        det += e00*e11*e22
        det += e01*e12*e20
        det += e02*e10*e21
        det -= e00*e12*e21
        det -= e01*e10*e22
        det -= e02*e11*e20
        return det
    }
    
    @inlinable
    public func inverted() throws -> HomogeneousTransformationMatrix {
        let det = determinant
        
        guard det != 0 else {
            throw MatrixInversionError.singularMatrix
        }
        
        let a00: Double = e11*e22 - e12*e21
        let a01: Double = e02*e21 - e01*e22
        let a02: Double = e01*e12 - e02*e11
        let a10: Double = e12*e20 - e10*e22
        let a11: Double = e00*e22 - e02*e20
        let a12: Double = e02*e10 - e00*e12
        let a20: Double = e10*e21 - e11*e20
        let a21: Double = e01*e20 - e00*e21
        let a22: Double = e00*e11 - e01*e10
        
        return HomogeneousTransformationMatrix(a00 / det, a01 / det, a02 / det,
                                               a10 / det, a11 / det, a12 / det,
                                               a20 / det, a21 / det, a22 / det)
    }
}

extension HomogeneousTransformationMatrix {
    public var identity: HomogeneousTransformationMatrix {
        return .init(1, 0, 0,
                     0, 1, 0,
                     0, 0, 1)
    }
}

extension HomogeneousTransformationMatrix {
    public static func project(source: ((x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double)),
                               target: ((x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double), (x: Double, y: Double))) throws -> HomogeneousTransformationMatrix {
        // a: (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1) to `source`
        let a: HomogeneousTransformationMatrix
        do {
            let mat = HomogeneousTransformationMatrix(source.0.x, source.1.x, source.2.x,
                                                      source.0.y, source.1.y, source.2.y,
                                                      1, 1, 1)
            let inv = try mat.inverted()
            let coef = inv * (source.3.x, source.3.y, 1)
            
            a = .init(coef.x*source.0.x, coef.y*source.1.x, coef.z*source.2.x,
                      coef.x*source.0.y, coef.y*source.1.y, coef.z*source.2.y,
                      coef.x, coef.y, coef.z)
        }
        // b: (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1) to `target`
        let b: HomogeneousTransformationMatrix
        do {
            let mat = HomogeneousTransformationMatrix(target.0.x, target.1.x, target.2.x,
                                                      target.0.y, target.1.y, target.2.y,
                                                      1, 1, 1)
            let inv = try mat.inverted()
            let coef = inv * (target.3.x, target.3.y, 1)
            
            b = .init(coef.x*target.0.x, coef.y*target.1.x, coef.z*target.2.x,
                      coef.x*target.0.y, coef.y*target.1.y, coef.z*target.2.y,
                      coef.x, coef.y, coef.z)
        }
        
        // a.inverted: `source` to (1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1)
        return try b * a.inverted()
    }
}

public func *(lhs: HomogeneousTransformationMatrix,
              rhs: HomogeneousTransformationMatrix) -> HomogeneousTransformationMatrix {
    let e00 = lhs.e00*rhs.e00 + lhs.e01*rhs.e10 + lhs.e02*rhs.e20
    let e01 = lhs.e00*rhs.e01 + lhs.e01*rhs.e11 + lhs.e02*rhs.e21
    let e02 = lhs.e00*rhs.e02 + lhs.e01*rhs.e12 + lhs.e02*rhs.e22
    
    let e10 = lhs.e10*rhs.e00 + lhs.e11*rhs.e10 + lhs.e12*rhs.e20
    let e11 = lhs.e10*rhs.e01 + lhs.e11*rhs.e11 + lhs.e12*rhs.e21
    let e12 = lhs.e10*rhs.e02 + lhs.e11*rhs.e12 + lhs.e12*rhs.e22
    
    let e20 = lhs.e20*rhs.e00 + lhs.e21*rhs.e10 + lhs.e22*rhs.e20
    let e21 = lhs.e20*rhs.e01 + lhs.e21*rhs.e11 + lhs.e22*rhs.e21
    let e22 = lhs.e20*rhs.e02 + lhs.e21*rhs.e12 + lhs.e22*rhs.e22
    
    return HomogeneousTransformationMatrix(e00, e01, e02,
                                           e10, e11, e12,
                                           e20, e21, e22)
}

public func *(lhs: HomogeneousTransformationMatrix,
              rhs: (x: Double, y: Double)) -> (x: Double, y: Double) {
    let (x, y, w) = lhs * (rhs.x, rhs.y, 1)
    return (x / w, y / w)
}

public func *(lhs: HomogeneousTransformationMatrix,
              rhs: (x: Double, y: Double, z: Double)) -> (x: Double, y: Double, z: Double) {
    let x = lhs.e00*rhs.x + lhs.e01*rhs.y + lhs.e02*rhs.z
    let y = lhs.e10*rhs.x + lhs.e11*rhs.y + lhs.e12*rhs.z
    let z = lhs.e20*rhs.x + lhs.e21*rhs.y + lhs.e22*rhs.z
    return (x, y, z)
}

// MARK: - Error

public enum MatrixInversionError: Error {
    case singularMatrix
}
