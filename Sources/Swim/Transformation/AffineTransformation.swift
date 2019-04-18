import Foundation

public struct AffineTransformation<T: BinaryFloatingPoint> {
    public var a: T
    public var b: T
    public var c: T
    public var d: T
    public var tx: T
    public var ty: T
    
    @inlinable
    public init(a: T, b: T, c: T, d: T, tx: T, ty: T) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.tx = tx
        self.ty = ty
    }
    
    @inlinable
    public func inverted() throws -> AffineTransformation<T> {
        var inv = self
        let delta = a*d - b*c
        
        guard delta != 0 else {
            throw MatrixInversionError.singularMatrix
        }
        
        inv.a = d / delta
        inv.b /= -delta
        inv.c /= -delta
        inv.d = a / delta
        
        inv.tx *= -d
        inv.tx += b*ty
        inv.tx /= delta
        
        inv.ty *= -a
        inv.ty += c*tx
        inv.ty /= delta
        
        return inv
    }
}

extension AffineTransformation: HomogeneousTransformationMatrixProtocol {
    @inlinable
    public var matrix: HomogeneousTransformationMatrix<T> {
        return HomogeneousTransformationMatrix(elements: [a, b, tx,
                                                          c, d, ty,
                                                          0, 0, 1])
    }
}

extension AffineTransformation {
    @inlinable
    public static var identity: AffineTransformation<T> {
        return AffineTransformation(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    }
    
    @inlinable
    public static func translation(x: T, y: T) -> AffineTransformation<T> {
        return AffineTransformation(a: 1, b: 0, c: 0, d: 1, tx: x, ty: y)
    }
    
    @inlinable
    public static func scale(x: T, y: T) -> AffineTransformation<T> {
        return AffineTransformation(a: x, b: 0, c: 0, d: y, tx: 0, ty: 0)
    }
}

extension AffineTransformation where T == Float {
    @inlinable
    public static func rotation(angle: T) -> AffineTransformation<T> {
        let sinx = sin(angle)
        let cosx = cos(angle)
        return AffineTransformation(a: cosx, b: -sinx,
                                    c: sinx, d: cosx,
                                    tx: 0, ty: 0)
    }
    
    @inlinable
    public init(scale: (x: T, y: T), rotation: T, translation: (x: T, y: T)) {
        self = AffineTransformation.translation(x: translation.x, y: translation.y)
            * AffineTransformation.rotation(angle: rotation)
            * AffineTransformation.scale(x: scale.x, y: scale.y)
    }
}

extension AffineTransformation where T == Double {
    @inlinable
    public static func rotation(angle: T) -> AffineTransformation<T> {
        let sinx = sin(angle)
        let cosx = cos(angle)
        return AffineTransformation(a: cosx, b: -sinx,
                                    c: sinx, d: cosx,
                                    tx: 0, ty: 0)
    }
    
    @inlinable
    public init(scale: (x: T, y: T), rotation: T, translation: (x: T, y: T)) {
        self = AffineTransformation.translation(x: translation.x, y: translation.y)
            * AffineTransformation.rotation(angle: rotation)
            * AffineTransformation.scale(x: scale.x, y: scale.y)
    }
}

@inlinable
public func *<T>(lhs: AffineTransformation<T>, rhs: AffineTransformation<T>) -> AffineTransformation<T> {
    var tr = AffineTransformation<T>.identity
    tr.a = lhs.a * rhs.a
    tr.a += lhs.b * rhs.c
    tr.b = lhs.a * rhs.b
    tr.b += lhs.b * rhs.d
    tr.c = lhs.c * rhs.a
    tr.c += lhs.d * rhs.c
    tr.d = lhs.c * rhs.b
    tr.d += lhs.d * rhs.d
    tr.tx = lhs.a * rhs.tx
    tr.tx += lhs.b * rhs.ty
    tr.tx += lhs.tx
    tr.ty = lhs.c * rhs.tx
    tr.ty += lhs.d * rhs.ty
    tr.ty += lhs.ty
    return tr
}

@inlinable
func *<T>(lhs: AffineTransformation<T>, rhs: (x: T, y: T)) -> (x: T, y: T) {
    var x: T = lhs.a * rhs.x
    x += lhs.b * rhs.y
    x += lhs.tx
    var y: T = lhs.c * rhs.x
    y += lhs.d * rhs.y
    y += lhs.ty
    return (x, y)
}
