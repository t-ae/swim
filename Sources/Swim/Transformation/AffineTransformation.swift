import Foundation

public struct AffineTransformation<T: BinaryFloatingPoint> {
    public var a: T
    public var b: T
    public var c: T
    public var d: T
    public var tx: T
    public var ty: T
    
    public var matrix: [T] {
        return [a, b, tx,
                c, d, ty,
                0, 0, 1]
    }
    
    public var inverse: AffineTransformation<T> {
        var inv = self
        let delta = a*d - b*c
        
        precondition(delta != 0, "AffineTransformation is singular.")
        
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

public func *=<T>(lhs: inout AffineTransformation<T>, rhs: AffineTransformation<T>) {
    lhs = lhs * rhs
}

func *<T>(lhs: AffineTransformation<T>, rhs: (x: T, y: T)) -> (x: T, y: T) {
    var x: T = lhs.a * rhs.x
    x += lhs.b * rhs.y
    x += lhs.tx
    var y: T = lhs.c * rhs.x
    y += lhs.d * rhs.y
    y += lhs.ty
    return (x, y)
}

extension Image where T: BinaryFloatingPoint {
    func _warpAffine(baseImage: inout Image<P, T>,
                           transformation: AffineTransformation<T>,
                           interpolation: Interpolation = .bilinear) {
        
        // shorthand
        let tr = transformation
        let inv = tr.inverse
        
        let intpl: (T, T) -> Pixel<P, T>
        switch interpolation {
        case .nearestNeighbor:
            intpl = self.nearestNeighbor
        case .bilinear:
            intpl = self.interpolateBilinear
        }
        
        // Calculate draw range
        let x1Range: CountableClosedRange<Int>
        let y1Range: CountableClosedRange<Int>
        do {
            let lt: (x: T, y: T) = tr * (0, 0)
            let rt: (x: T, y: T) = tr * (T(width), 0)
            let lb: (x: T, y: T) = tr * (0, T(height))
            let rb: (x: T, y: T) = tr * (T(width), T(height))
            
            let xs: [T] = [lt.x, rt.x, lb.x, rb.x]
            let minX: Int = run {
                let m = Foundation.floor(xs.min()!)
                return max(Int(m), 0)
            }
            let maxX: Int = run {
                let m = Foundation.ceil(xs.max()!)
                return min(Int(m), baseImage.width - 1)
            }
            let ys: [T] = [lt.y, rt.y, lb.y, rb.y]
            let minY: Int = run {
                let m = Foundation.floor(ys.min()!)
                return max(Int(m), 0)
            }
            let maxY: Int = run {
                let m = Foundation.ceil(ys.max()!)
                return min(Int(m), baseImage.height-1)
            }
            
            x1Range = minX...maxX
            y1Range = minY...maxY
        }
        
        for y1 in y1Range {
            for x1 in x1Range {
                let (x0, y0) = inv * (T(x1), T(y1))
                
                guard 0 <= x0 && x0 < T(width) && 0 <= y0 && y0 < T(height) else {
                    continue
                }
                
                baseImage[unsafe: x1, y1] = intpl(x0, y0)
            }
        }
    }
    
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}
