
extension Image where P == Intensity, T == UInt8 {
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _minimumFilter(kernelSize: kernelSize)
    }

    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _maximumFilter(kernelSize: kernelSize)
    }

    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        return _medianFilter(kernelSize: kernelSize)
    }
}

extension Image where P == Intensity, T == Int {
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _minimumFilter(kernelSize: kernelSize)
    }

    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _maximumFilter(kernelSize: kernelSize)
    }

    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        return _medianFilter(kernelSize: kernelSize)
    }
}

extension Image where P == Intensity, T == Float {
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _minimumFilter(kernelSize: kernelSize)
    }

    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _maximumFilter(kernelSize: kernelSize)
    }

    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        return _medianFilter(kernelSize: kernelSize)
    }
}

extension Image where P == Intensity, T == Double {
    public func minimumFilter(kernelSize: Int) -> Image<P, T> {
        return _minimumFilter(kernelSize: kernelSize)
    }

    public func maximumFilter(kernelSize: Int) -> Image<P, T> {
        return _maximumFilter(kernelSize: kernelSize)
    }

    public func medianFilter(kernelSize: Int) -> Image<P, T> {
        return _medianFilter(kernelSize: kernelSize)
    }
}

