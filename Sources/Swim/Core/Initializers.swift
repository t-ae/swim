extension Image where P == Intensity {
    @inlinable
    public init(width: Int, height: Int, intensity: [T]) {
        self.init(width: width, height: height, data: intensity)
    }
}

extension Image where P == IntensityAlpha {
    @inlinable
    public init(width: Int, height: Int, intensityAlpha: [T]) {
        self.init(width: width, height: height, data: intensityAlpha)
    }
}

extension Image where P == RGB {
    @inlinable
    public init(width: Int, height: Int, rgb: [T]) {
        self.init(width: width, height: height, data: rgb)
    }
}

extension Image where P == RGBA {
    @inlinable
    public init(width: Int, height: Int, rgba: [T]) {
        self.init(width: width, height: height, data: rgba)
    }
}

extension Image where P == ARGB {
    @inlinable
    public init(width: Int, height: Int, argb: [T]) {
        self.init(width: width, height: height, data: argb)
    }
}
