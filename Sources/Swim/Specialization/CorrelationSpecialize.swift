
public func calculateSSD(_ a: Image<Intensity, Float>,
                         _ b: Image<Intensity, Float>) -> Float {
    return _calculateSSD(a, b)
}

public func calculateSAD(_ a: Image<Intensity, Float>,
                         _ b: Image<Intensity, Float>) -> Float {
    return _calculateSAD(a, b)
}

public func calculateNCC(_ a: Image<Intensity, Float>,
                         _ b: Image<Intensity, Float>) -> Float {
    return _calculateNCC(a, b)
}

public func calculateZNCC(_ a: Image<Intensity, Float>,
                          _ b: Image<Intensity, Float>) -> Float {
    return _calculateZNCC(a, b)
}

public func calculateSSD(_ a: Image<Intensity, Double>,
                         _ b: Image<Intensity, Double>) -> Double {
    return _calculateSSD(a, b)
}

public func calculateSAD(_ a: Image<Intensity, Double>,
                         _ b: Image<Intensity, Double>) -> Double {
    return _calculateSAD(a, b)
}

public func calculateNCC(_ a: Image<Intensity, Double>,
                         _ b: Image<Intensity, Double>) -> Double {
    return _calculateNCC(a, b)
}

public func calculateZNCC(_ a: Image<Intensity, Double>,
                          _ b: Image<Intensity, Double>) -> Double {
    return _calculateZNCC(a, b)
}

