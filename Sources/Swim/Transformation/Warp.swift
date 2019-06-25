import Foundation

// MARK: - Warp

extension Image where T: BinaryFloatingPoint {
    /// Warp input image with specified transformation matrix.
    /// Use bilinear interpolation. Pixels outside the original image are filled with 0.
    /// Output image will preserve size of `self`.
    ///
    /// - Parameters:
    ///   - transformation: Homogeneous transformation matrix.
    @inlinable
    public func warp<M: HomogeneousTransformationMatrix>(transformation: M) throws -> Image<P, T> {
        
        return try warp(transformation: transformation,
                        outputSize: (width, height))
    }
    
    /// Warp input image with specified transformation matrix.
    /// Output image will preserve size of `self`.
    ///
    /// - Parameters:
    ///   - transformation: Homogeneous transformation matrix.
    ///   - interpolator: Specify what interpolation method to calculate pixel values.
    @inlinable
    public func warp<M: HomogeneousTransformationMatrix, Intpl: Interpolator>(
        transformation: M,
        interpolator: Intpl) throws -> Image<P, T> where Intpl.P == P, Intpl.T == T {
        return try warp(transformation: transformation,
                        outputSize: (width, height),
                        interpolator: interpolator)
    }
    
    /// Warp input image with specified transformation matrix.
    /// Use bilinear interpolation. Pixels outside the original image are filled with 0.
    ///
    /// - Parameters:
    ///   - transformation: Homogeneous transformation matrix.
    ///   - outputSize: Output image size.
    @inlinable
    public func warp<M: HomogeneousTransformationMatrix>(
        transformation: M,
        outputSize: (width: Int, height: Int)) throws -> Image<P, T> {
        return try warp(transformation: transformation,
                        outputSize: outputSize,
                        interpolator: BilinearInterpolator<P, T>())
    }
    
    /// Warp input image with specified transformation matrix.
    ///
    /// - Parameters:
    ///   - transformation: Homogeneous transformation matrix.
    ///   - outputSize: Output image size.
    ///   - interpolator: Specify what interpolation method to calculate pixel values.
    @inlinable
    public func warp<M: HomogeneousTransformationMatrix, Intpl: Interpolator>(
        transformation: M,
        outputSize: (width: Int, height: Int),
        interpolator: Intpl) throws -> Image<P, T> where Intpl.P == P, Intpl.T == T {
        
        let inv = try transformation.inverted()
        
        return .createWithUnsafePixelRef(width: outputSize.width, height: outputSize.height) { ref in
            let (x0, y0) = inv * (Double(ref.x), Double(ref.y))
            interpolator.interpolate(x: x0, y: y0, in: self, into: ref)
        }
    }
}
