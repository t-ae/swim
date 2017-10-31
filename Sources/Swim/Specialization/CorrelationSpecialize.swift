
extension Correlation where T == Float {
    public static func ssd(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _ssd(a, b)
    }
    public static func sad(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _sad(a, b)
    }
    public static func ncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _ncc(a, b)
    }
    public static func zncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _zncc(a, b)
    }
}

extension Correlation where T == Double {
    public static func ssd(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _ssd(a, b)
    }
    public static func sad(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _sad(a, b)
    }
    public static func ncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _ncc(a, b)
    }
    public static func zncc(_ a: Image<Intensity, T>, _ b: Image<Intensity, T>) -> T {
        return _zncc(a, b)
    }
}

