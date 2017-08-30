
extension Image where P == Intensity, T == UInt8 {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == Intensity, T == Int {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == Intensity, T == Float {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == Intensity, T == Double {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGB, T == UInt8 {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGB, T == Int {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGB, T == Float {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGB, T == Double {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGBA, T == UInt8 {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGBA, T == Int {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGBA, T == Float {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == RGBA, T == Double {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == ARGB, T == UInt8 {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == ARGB, T == Int {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == ARGB, T == Float {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

extension Image where P == ARGB, T == Double {
    public mutating func convert(_ f: (Int, Int, Pixel<P, T>)->Pixel<P, T>) {
        self._convert(f)
    }

    public mutating func channelwiseConvert(_ f: (T)->T) {
        self._channelwiseConvert(f)
    }

    public func channelwiseConverted(_ f: (T) -> UInt8) -> Image<P, UInt8> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Int) -> Image<P, Int> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Float) -> Image<P, Float> {
        return self._channelwiseConverted(f)
    }

    public func channelwiseConverted(_ f: (T) -> Double) -> Image<P, Double> {
        return self._channelwiseConverted(f)
    }
}

