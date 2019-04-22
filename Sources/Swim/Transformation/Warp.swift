import Foundation

public enum MatrixInversionError: Error {
    case singularMatrix
}

// MARK: - HomogeneousTransformationMatrixProtocol
public protocol HomogeneousTransformationMatrixProtocol {
    associatedtype T: BinaryFloatingPoint
    associatedtype InvertedMatrix: HomogeneousTransformationMatrixProtocol where InvertedMatrix.T == T
    func inverted() throws -> InvertedMatrix
    static func *(lhs: Self, rhs: (x: T, y: T)) -> (x: T, y: T)
}


// MARK: - HomogeneousTransformationMatrix
public struct HomogeneousTransformationMatrix<T: BinaryFloatingPoint>: HomogeneousTransformationMatrixProtocol {
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

public func *<T: BinaryFloatingPoint>(lhs: HomogeneousTransformationMatrix<T>,
                                      rhs: (x: T, y: T)) -> (x: T, y: T) {
    let e = lhs.elements
    let x = e[0]*rhs.0 + e[1]*rhs.1 + e[2]
    let y = e[3]*rhs.0 + e[4]*rhs.1 + e[5]
    let w = e[6]*rhs.0 + e[7]*rhs.1 + e[8]
    return (x / w, y / w)
}

// MARK: - Warp

extension Image where T: BinaryFloatingPoint {
    @inlinable
    public func warp<M: HomogeneousTransformationMatrixProtocol>(transformation: M) throws -> Image<P, T> where M.T == T {
        
        return try warp(transformation: transformation,
                        outputSize: (width, height))
    }
    
    @inlinable
    public func warp<M: HomogeneousTransformationMatrixProtocol, Intpl: Interpolator>(
        transformation: M,
        interpolator: Intpl) throws -> Image<P, T> where M.T == T, Intpl.T == T {
        return try warp(transformation: transformation,
                        outputSize: (width, height),
                        interpolator: interpolator)
    }
    
    @inlinable
    public func warp<M: HomogeneousTransformationMatrixProtocol>(
        transformation: M,
        outputSize: (width: Int, height: Int)) throws -> Image<P, T> where M.T == T {
        return try warp(transformation: transformation,
                        outputSize: outputSize,
                        interpolator: BilinearInterpolator<T>())
    }
    
    @inlinable
    public func warp<M: HomogeneousTransformationMatrixProtocol, Intpl: Interpolator>(
        transformation: M,
        outputSize: (width: Int, height: Int),
        interpolator: Intpl) throws -> Image<P, T> where M.T == T, Intpl.T == T {
        
        var dest = Image<P, T>(width: outputSize.width,
                               height: outputSize.height,
                               value: T.swimDefaultValue)

        let inv = try transformation.inverted()

        for y1 in 0..<outputSize.height {
            for x1 in 0..<outputSize.width {
                let (x0, y0) = inv * (T(x1), T(y1))

                dest[unsafe: x1, y1] = interpolator.interpolate(x: x0, y: y0, in: self)
            }
        }
        
        return dest
    }
}
