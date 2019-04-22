import Foundation

public struct AffineTransformation<T: BinaryFloatingPoint> {
    public var a: T
    public var b: T
    public var tx: T
    public var c: T
    public var d: T
    public var ty: T
    
    @inlinable
    public init(a: T, b: T, tx: T, c: T, d: T, ty: T) {
        self.a = a
        self.b = b
        self.tx = tx
        self.c = c
        self.d = d
        self.ty = ty
    }
}

extension AffineTransformation {
    @inlinable
    public static var identity: AffineTransformation<T> {
        return AffineTransformation(a: 1, b: 0, tx: 0,
                                    c: 0, d: 1, ty: 0)
    }
    
    @inlinable
    public static func translation(x: T, y: T) -> AffineTransformation<T> {
        return AffineTransformation(a: 1, b: 0, tx: x,
                                    c: 0, d: 1, ty: y)
    }
    
    @inlinable
    public static func scale(x: T, y: T) -> AffineTransformation<T> {
        return AffineTransformation(a: x, b: 0, tx: 0,
                                    c: 0, d: y, ty: 0)
    }
}

extension AffineTransformation where T == Float {
    @inlinable
    public static func rotation(angle: T) -> AffineTransformation<T> {
        let sinx = sin(angle)
        let cosx = cos(angle)
        return AffineTransformation(a: cosx, b: -sinx, tx: 0,
                                    c: sinx, d: cosx, ty: 0)
    }
    
    @inlinable
    public init(scale: (x: T, y: T) = (0, 0),
                rotation: T = 0,
                translation: (x: T, y: T) = (0, 0)) {
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
        return AffineTransformation(a: cosx, b: -sinx, tx: 0,
                                    c: sinx, d: cosx, ty: 0)
    }
    
    @inlinable
    public init(scale: (x: T, y: T) = (1, 1),
                rotation: T = 0,
                translation: (x: T, y: T) = (0, 0)) {
        self = AffineTransformation.translation(x: translation.x, y: translation.y)
            * AffineTransformation.rotation(angle: rotation)
            * AffineTransformation.scale(x: scale.x, y: scale.y)
    }
}

extension AffineTransformation: HomogeneousTransformationMatrixProtocol {
    @inlinable
    public func inverted() throws -> AffineTransformation<T> {
        var inv = self
        let det = a*d - b*c
        
        guard det != 0 else {
            throw MatrixInversionError.singularMatrix
        }
        
        inv.a = d / det
        inv.b /= -det
        inv.c /= -det
        inv.d = a / det
        
        inv.tx *= -d
        inv.tx += b*ty
        inv.tx /= det
        
        inv.ty *= -a
        inv.ty += c*tx
        inv.ty /= det
        
        return inv
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
public func *<T>(lhs: AffineTransformation<T>, rhs: (x: T, y: T)) -> (x: T, y: T) {
    var x: T = lhs.a * rhs.x
    x += lhs.b * rhs.y
    x += lhs.tx
    var y: T = lhs.c * rhs.x
    y += lhs.d * rhs.y
    y += lhs.ty
    return (x, y)
}

extension HomogeneousTransformationMatrix {
    public init(from affineTransformation: AffineTransformation<T>) {
        self.init(elements: [affineTransformation.a, affineTransformation.b, affineTransformation.tx,
                             affineTransformation.c, affineTransformation.d, affineTransformation.ty,
                             0, 0, 1])
    }
}
