
extension Image where P == Intensity, T == Bool {
    public mutating func convert(_ f: (Int, Int, T)->T) {
        _convert(f)
    }
}

extension Image where P == Intensity, T == UInt8 {
    public mutating func convert(_ f: (Int, Int, T)->T) {
        _convert(f)
    }
}

extension Image where P == Intensity, T == Int {
    public mutating func convert(_ f: (Int, Int, T)->T) {
        _convert(f)
    }
}

extension Image where P == Intensity, T == Float {
    public mutating func convert(_ f: (Int, Int, T)->T) {
        _convert(f)
    }
}

extension Image where P == Intensity, T == Double {
    public mutating func convert(_ f: (Int, Int, T)->T) {
        _convert(f)
    }
}

extension Image where P == Intensity, T == Bool {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == Intensity, T == UInt8 {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == Intensity, T == Int {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == Intensity, T == Float {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == Intensity, T == Double {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGB, T == Bool {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGB, T == UInt8 {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGB, T == Int {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGB, T == Float {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGB, T == Double {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGBA, T == Bool {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGBA, T == UInt8 {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGBA, T == Int {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGBA, T == Float {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == RGBA, T == Double {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == ARGB, T == Bool {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == ARGB, T == UInt8 {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == ARGB, T == Int {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == ARGB, T == Float {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

extension Image where P == ARGB, T == Double {
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Bool) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Bool>) -> Image<Intensity, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Bool>) -> Image<RGB, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Bool>) -> Image<RGBA, Bool> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Bool>) -> Image<ARGB, Bool> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->UInt8) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, UInt8>) -> Image<Intensity, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, UInt8>) -> Image<RGB, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, UInt8>) -> Image<RGBA, UInt8> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, UInt8>) -> Image<ARGB, UInt8> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Int) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Int>) -> Image<Intensity, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Int>) -> Image<RGB, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Int>) -> Image<RGBA, Int> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Int>) -> Image<ARGB, Int> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Float) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Float>) -> Image<Intensity, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Float>) -> Image<RGB, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Float>) -> Image<RGBA, Float> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Float>) -> Image<ARGB, Float> {
        return _converted(f)
    }

    public func converted(_ f: (Int, Int, Pixel<P, T>)->Double) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<Intensity, Double>) -> Image<Intensity, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGB, Double>) -> Image<RGB, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<RGBA, Double>) -> Image<RGBA, Double> {
        return _converted(f)
    }
    public func converted(_ f: (Int, Int, Pixel<P, T>)->Pixel<ARGB, Double>) -> Image<ARGB, Double> {
        return _converted(f)
    }

}

