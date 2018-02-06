import Foundation

public struct AffineTransformation<T: BinaryFloatingPoint> {
    public let a: T
    public let b: T
    public let c: T
    public let d: T
    public let tx: T
    public let ty: T
    
    public var matrix: [T] {
        return [a, b, tx,
                c, d, ty,
                0, 0, 1]
    }
}

extension AffineTransformation {
    public static var identity: AffineTransformation<T> {
        return AffineTransformation(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    }
    
    public static func translate(x: T, y: T) -> AffineTransformation<T> {
        return AffineTransformation(a: 1, b: 0, c: 0, d: 1, tx: x, ty: y)
    }
    
    public static func scale(x: T, y: T) -> AffineTransformation<T> {
        return AffineTransformation(a: x, b: 0, c: 0, d: y, tx: 0, ty: 0)
    }
}

extension AffineTransformation where T == Float {
    public static func rotate(angle: T) -> AffineTransformation<T> {
        let sinx = sin(angle)
        let cosx = cos(angle)
        return AffineTransformation(a: cosx, b: -sinx,
                                    c: sinx, d: cosx,
                                    tx: 0, ty: 0)
    }
}

extension AffineTransformation where T == Double {
    public static func rotate(angle: T) -> AffineTransformation<T> {
        let sinx = sin(angle)
        let cosx = cos(angle)
        return AffineTransformation(a: cosx, b: -sinx,
                                    c: sinx, d: cosx,
                                    tx: 0, ty: 0)
    }
}

public func *<T>(lhs: AffineTransformation<T>, rhs: AffineTransformation<T>) -> AffineTransformation<T> {
    let a = lhs.a * rhs.a + lhs.b * rhs.c
    let b = lhs.a * rhs.b + lhs.b * rhs.d
    let c = lhs.c * rhs.a + lhs.d * rhs.c
    let d = lhs.c * rhs.b + lhs.d * rhs.d
    let tx = lhs.a * rhs.tx + lhs.b * rhs.ty + lhs.tx
    let ty = lhs.c * rhs.tx + lhs.d * rhs.ty + lhs.ty
    return AffineTransformation(a: a, b: b, c: c, d: d, tx: tx, ty: ty)
}

extension Image where T: BinaryFloatingPoint {
    public func warpAffine(baseImage: inout Image<P, T>,
                           transformation: AffineTransformation<T>) {
        
        let ad_minus_bc: T = transformation.a * transformation.d - transformation.b * transformation.c
        let dtx_minus_bty: T = transformation.d * transformation.tx - transformation.b * transformation.ty
        
        let cb_minus_ad: T = transformation.c * transformation.b - transformation.a * transformation.d
        let ctx_minus_aty: T = transformation.c * transformation.tx - transformation.a * transformation.ty
        
        for y1 in 0..<baseImage.height {
            for x1 in 0..<baseImage.width {
                var x0: T = transformation.d * T(x1) - transformation.b * T(y1)
                x0 -= dtx_minus_bty
                x0 /= ad_minus_bc
                
                guard 0 <= x0 && x0 <= T(width-1) else {
                    continue
                }
                
                var y0: T = transformation.c * T(x1) - transformation.a * T(y1)
                y0 -= ctx_minus_aty
                y0 /= cb_minus_ad
                
                guard 0 <= y0 && y0 <= T(height-1) else {
                    continue
                }
                
                baseImage[x1, y1] = bilinearInterpolation(x: x0, y: y0)
            }
        }
    }
}
