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

func *<T>(lhs: AffineTransformation<T>, rhs: (x: T, y: T)) -> (x: T, y: T) {
    let x = lhs.a * rhs.x + lhs.b * rhs.y + lhs.tx
    let y = lhs.c * rhs.x + lhs.d * rhs.y + lhs.ty
    return (x, y)
}

extension Image where T: BinaryFloatingPoint {
    public func warpAffine(baseImage: inout Image<P, T>,
                           transformation: AffineTransformation<T>,
                           interpolation: Interpolation = .bilinear) {
        
        // shorthand
        let tr = transformation
        
        let intpl: (T, T) -> Pixel<P, T>
        switch interpolation {
        case .nearestNeighbor:
            intpl = self.nearestNeighbor
        case .bilinear:
            intpl = self.bilinearInterpolation
        }
        
        // Calculate draw range
        let x1Range: CountableClosedRange<Int>
        let y1Range: CountableClosedRange<Int>
        do {
            let lt = tr * (0, 0)
            let rt = tr * (T(width), 0)
            let lb = tr * (0, T(height))
            let rb = tr * (T(width), T(height))
            
            let xs = [lt.x, rt.x, lb.x, rb.x]
            let minX = max(Int(Foundation.floor(xs.min()!)), 0)
            let maxX = min(Int(Foundation.ceil(xs.max()!)), baseImage.width-1)
            let ys = [lt.y, rt.y, lb.y, rb.y]
            let minY = max(Int(Foundation.floor(ys.min()!)), 0)
            let maxY = min(Int(Foundation.ceil(ys.max()!)), baseImage.height-1)
            
            x1Range = minX...maxX
            y1Range = minY...maxY
        }
        
        // for inversion
        let ad_minus_bc: T = tr.a * tr.d - tr.b * tr.c
        let dtx_minus_bty: T = tr.d * tr.tx - tr.b * tr.ty
        
        let cb_minus_ad: T = tr.c * tr.b - tr.a * tr.d
        let ctx_minus_aty: T = tr.c * tr.tx - tr.a * tr.ty
        
        for y1 in y1Range {
            for x1 in x1Range {
                var x0: T = tr.d * T(x1) - tr.b * T(y1)
                x0 -= dtx_minus_bty
                x0 /= ad_minus_bc
                
                guard 0 <= x0 && x0 <= T(width-1) else {
                    continue
                }
                
                var y0: T = tr.c * T(x1) - tr.a * T(y1)
                y0 -= ctx_minus_aty
                y0 /= cb_minus_ad
                
                guard 0 <= y0 && y0 <= T(height-1) else {
                    continue
                }
                
                baseImage[x1, y1] = intpl(x0, y0)
            }
        }
    }
}
