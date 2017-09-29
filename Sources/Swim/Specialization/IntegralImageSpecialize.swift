
extension Image where P == Intensity, T == Int {
    public func toIntegralImage() -> Image<Intensity, T> {
        return _toIntegralImage()
    }
}

extension Image where P == Intensity, T == Float {
    public func toIntegralImage() -> Image<Intensity, T> {
        return _toIntegralImage()
    }
}

extension Image where P == Intensity, T == Double {
    public func toIntegralImage() -> Image<Intensity, T> {
        return _toIntegralImage()
    }
}

