import Foundation

public struct AffineTransformation {
    public var a: Double
    public var b: Double
    public var tx: Double
    public var c: Double
    public var d: Double
    public var ty: Double
    
    @inlinable
    public init(a: Double, b: Double, tx: Double, c: Double, d: Double, ty: Double) {
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
    public static var identity: AffineTransformation {
        return AffineTransformation(a: 1, b: 0, tx: 0,
                                    c: 0, d: 1, ty: 0)
    }
    
    @inlinable
    public static func translation(x: Double, y: Double) -> AffineTransformation {
        return AffineTransformation(a: 1, b: 0, tx: x,
                                    c: 0, d: 1, ty: y)
    }
    
    @inlinable
    public static func scale(x: Double, y: Double) -> AffineTransformation {
        return AffineTransformation(a: x, b: 0, tx: 0,
                                    c: 0, d: y, ty: 0)
    }
    
    @inlinable
    public static func rotation(angle: Double) -> AffineTransformation {
        let sinx = sin(angle)
        let cosx = cos(angle)
        return AffineTransformation(a: cosx, b: -sinx, tx: 0,
                                    c: sinx, d: cosx, ty: 0)
    }
    
    @inlinable
    public init(scale: (x: Double, y: Double) = (1, 1),
                rotation: Double = 0,
                translation: (x: Double, y: Double) = (0, 0)) {
        self = AffineTransformation.translation(x: translation.x, y: translation.y)
            * AffineTransformation.rotation(angle: rotation)
            * AffineTransformation.scale(x: scale.x, y: scale.y)
    }
}

extension AffineTransformation: HomogeneousTransformationMatrix {
    @inlinable
    public func inverted() throws -> AffineTransformation {
        let det = a*d - b*c
        
        guard det != 0 else {
            throw MatrixInversionError.singularMatrix
        }
        
        var inv = self
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
public func *(lhs: AffineTransformation, rhs: AffineTransformation) -> AffineTransformation {
    let a = lhs.a * rhs.a + lhs.b * rhs.c
    let b = lhs.a * rhs.b + lhs.b * rhs.d
    let tx = lhs.a * rhs.tx + lhs.b * rhs.ty + lhs.tx
    let c = lhs.c * rhs.a + lhs.d * rhs.c
    let d = lhs.c * rhs.b + lhs.d * rhs.d
    let ty = lhs.c * rhs.tx + lhs.d * rhs.ty + lhs.ty
    return .init(a: a, b: b, tx: tx, c: c, d: d, ty: ty)
}

@inlinable
public func *(lhs: AffineTransformation, rhs: (x: Double, y: Double)) -> (x: Double, y: Double) {
    var x: Double = lhs.a * rhs.x
    x += lhs.b * rhs.y
    x += lhs.tx
    var y: Double = lhs.c * rhs.x
    y += lhs.d * rhs.y
    y += lhs.ty
    return (x, y)
}

extension ProjectiveTransformation {
    public init(from affineTransformation: AffineTransformation) {
        self.init(affineTransformation.a, affineTransformation.b, affineTransformation.tx,
                  affineTransformation.c, affineTransformation.d, affineTransformation.ty,
                  0, 0, 1)
    }
}
