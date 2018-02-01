
extension Image where P == RGB, DT == Int {
    public func bayered(pattern: BayerPattern) -> Image<Intensity, T> {
        return _bayered(pattern: pattern)
    }
}

extension Image where P == RGB, DT == Float {
    public func bayered(pattern: BayerPattern) -> Image<Intensity, T> {
        return _bayered(pattern: pattern)
    }
}

extension Image where P == RGB, DT == Double {
    public func bayered(pattern: BayerPattern) -> Image<Intensity, T> {
        return _bayered(pattern: pattern)
    }
}


extension Image where P == Intensity, DT == Int {
    public func debayered(pattern: BayerPattern) -> Image<RGB, T> {
        return _debayered(pattern: pattern)
    }
}

extension Image where P == Intensity, DT == Float {
    public func debayered(pattern: BayerPattern) -> Image<RGB, T> {
        return _debayered(pattern: pattern)
    }
}

extension Image where P == Intensity, DT == Double {
    public func debayered(pattern: BayerPattern) -> Image<RGB, T> {
        return _debayered(pattern: pattern)
    }
}

