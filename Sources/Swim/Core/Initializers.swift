extension Image where P == Intensity {
    public init(width: Int, height: Int, intensity: [T]) {
        self.init(width: width, height: height, data: intensity)
    }
}

extension Image where P == IntensityAlpha {
    public init(width: Int, height: Int, intensityAlpha: [T]) {
        self.init(width: width, height: height, data: intensityAlpha)
    }
}

extension Image where P == RGB {
    public init(width: Int, height: Int, rgb: [T]) {
        self.init(width: width, height: height, data: rgb)
    }
}

extension Image where P == RGBA {
    public init(width: Int, height: Int, rgba: [T]) {
        self.init(width: width, height: height, data: rgba)
    }
}

extension Image where P == ARGB {
    public init(width: Int, height: Int, argb: [T]) {
        self.init(width: width, height: height, data: argb)
    }
}
