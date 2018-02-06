
extension Image where P == Intensity, T == Float {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == Intensity, T == Double {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == IntensityAlpha, T == Float {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == IntensityAlpha, T == Double {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == RGB, T == Float {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == RGB, T == Double {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == RGBA, T == Float {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == RGBA, T == Double {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == ARGB, T == Float {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

extension Image where P == ARGB, T == Double {
    public func warpAffine(baseImage: inout Image<P, T>,
                            transformation: AffineTransformation<T>,
                            interpolation: Interpolation = .bilinear) {
        _warpAffine(baseImage: &baseImage,
                    transformation: transformation,
                    interpolation: interpolation)
    }
}

