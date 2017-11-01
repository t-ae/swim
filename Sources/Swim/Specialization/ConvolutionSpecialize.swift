
extension Image where P == Intensity, T == Int {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}

extension Image where P == Intensity, T == Float {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}

extension Image where P == Intensity, T == Double {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}

extension Image where P == RGB, T == Int {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}

extension Image where P == RGB, T == Float {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}

extension Image where P == RGB, T == Double {
    public func convoluted(_ filter: Image<Intensity, T>) -> Image<P, T> {
        return _convoluted(filter)
    }
}

