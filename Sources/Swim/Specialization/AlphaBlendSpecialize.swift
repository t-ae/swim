
extension Image where P == RGB, T == Float {
    public mutating func alphaBlend(with src: Image<RGBA, T>) {
        self._alphaBlend(with: src)
    }
    public mutating func alphaBlend(with src: Image<ARGB, T>) {
        self._alphaBlend(with: src)
    }
}

extension Image where P == RGB, T == Double {
    public mutating func alphaBlend(with src: Image<RGBA, T>) {
        self._alphaBlend(with: src)
    }
    public mutating func alphaBlend(with src: Image<ARGB, T>) {
        self._alphaBlend(with: src)
    }
}


extension Image where P == RGBA, T == Float {
    public mutating func alphaBlend(with src: Image<P, T>) {
        self._alphaBlend(with: src)
    }
}

extension Image where P == RGBA, T == Double {
    public mutating func alphaBlend(with src: Image<P, T>) {
        self._alphaBlend(with: src)
    }
}

extension Image where P == ARGB, T == Float {
    public mutating func alphaBlend(with src: Image<P, T>) {
        self._alphaBlend(with: src)
    }
}

extension Image where P == ARGB, T == Double {
    public mutating func alphaBlend(with src: Image<P, T>) {
        self._alphaBlend(with: src)
    }
}


