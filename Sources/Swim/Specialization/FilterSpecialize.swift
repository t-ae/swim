
extension Image where P == Intensity, T == Bool {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == Intensity, T == UInt8 {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == Intensity, T == Int {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == Intensity, T == Float {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == Intensity, T == Double {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == IntensityAlpha, T == Bool {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == IntensityAlpha, T == UInt8 {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == IntensityAlpha, T == Int {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == IntensityAlpha, T == Float {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == IntensityAlpha, T == Double {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGB, T == Bool {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGB, T == UInt8 {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGB, T == Int {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGB, T == Float {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGB, T == Double {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGBA, T == Bool {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGBA, T == UInt8 {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGBA, T == Int {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGBA, T == Float {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == RGBA, T == Double {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == ARGB, T == Bool {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == ARGB, T == UInt8 {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == ARGB, T == Int {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == ARGB, T == Float {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
    }
}

extension Image where P == ARGB, T == Double {
    public func filter(kernelSize: Int, kernelFunc: ([Pixel<P, T>?])->Pixel<P, T>) -> Image<P, T> {
        return _filter(kernelSize: kernelSize, kernelFunc: kernelFunc)
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

extension Image where P == IntensityAlpha, T == Int {
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

extension Image where P == IntensityAlpha, T == Float {
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

extension Image where P == IntensityAlpha, T == Double {
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

extension Image where P == RGB, T == Int {
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

extension Image where P == RGB, T == Float {
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

extension Image where P == RGB, T == Double {
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

extension Image where P == RGBA, T == Int {
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

extension Image where P == RGBA, T == Float {
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

extension Image where P == RGBA, T == Double {
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

extension Image where P == ARGB, T == Int {
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

extension Image where P == ARGB, T == Float {
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

extension Image where P == ARGB, T == Double {
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

