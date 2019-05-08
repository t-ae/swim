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

extension AffineTransformation: HomogeneousTransformationMatrixProtocol {
    @inlinable
    public func inverted() throws -> AffineTransformation {
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
public func *(lhs: AffineTransformation, rhs: AffineTransformation) -> AffineTransformation {
    var tr = AffineTransformation.identity
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
public func *(lhs: AffineTransformation, rhs: (x: Double, y: Double)) -> (x: Double, y: Double) {
    var x: Double = lhs.a * rhs.x
    x += lhs.b * rhs.y
    x += lhs.tx
    var y: Double = lhs.c * rhs.x
    y += lhs.d * rhs.y
    y += lhs.ty
    return (x, y)
}

extension HomogeneousTransformationMatrix {
    public init(from affineTransformation: AffineTransformation) {
        self.init(elements: [affineTransformation.a, affineTransformation.b, affineTransformation.tx,
                             affineTransformation.c, affineTransformation.d, affineTransformation.ty,
                             0, 0, 1])
    }
}
