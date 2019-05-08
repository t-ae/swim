import Foundation

public struct ProjectiveTransformation: HomogeneousTransformationMatrixProtocol {
    @usableFromInline
    let matrix: HomogeneousTransformationMatrix
    
    public init(from: ((Double, Double), (Double, Double), (Double, Double), (Double, Double)),
                to: ((Double, Double), (Double, Double), (Double, Double), (Double, Double))) throws {
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
        self.matrix = try b * a.inverted()
    }
    
    public func inverted() throws -> HomogeneousTransformationMatrix {
        return try matrix.inverted()
    }
}

@inlinable
public func *(lhs: ProjectiveTransformation, rhs: (x: Double, y: Double)) -> (x: Double, y: Double) {
    return lhs.matrix * rhs
}
