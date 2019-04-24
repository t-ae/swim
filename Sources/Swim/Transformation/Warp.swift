import Foundation

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
        interpolator: Intpl) throws -> Image<P, T> where M.T == T, Intpl.P == P, Intpl.T == T {
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
                        interpolator: BilinearInterpolator<P, T>())
    }
    
    @inlinable
    public func warp<M: HomogeneousTransformationMatrixProtocol, Intpl: Interpolator>(
        transformation: M,
        outputSize: (width: Int, height: Int),
        interpolator: Intpl) throws -> Image<P, T> where M.T == T, Intpl.P == P, Intpl.T == T {
        
        var dest = Image<P, T>(width: outputSize.width,
                               height: outputSize.height,
                               value: 0)

        let inv = try transformation.inverted()
        
        dest.pixelwiseConvert { ref in
            let (x0, y0) = inv * (T(ref.x), T(ref.y))
            interpolator.interpolate(x: x0, y: y0, in: self, into: ref)
        }
        
        return dest
    }
}
