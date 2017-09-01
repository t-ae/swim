
extension Image where P == IntensityAlpha, T == Bool {
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        self = compoundChannels(intensity: intensity, alpha: alpha)
    }
}

extension Image where P == IntensityAlpha, T == UInt8 {
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        self = compoundChannels(intensity: intensity, alpha: alpha)
    }
}

extension Image where P == IntensityAlpha, T == Int {
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        self = compoundChannels(intensity: intensity, alpha: alpha)
    }
}

extension Image where P == IntensityAlpha, T == Float {
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        self = compoundChannels(intensity: intensity, alpha: alpha)
    }
}

extension Image where P == IntensityAlpha, T == Double {
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        self = compoundChannels(intensity: intensity, alpha: alpha)
    }
}

extension Image where P == RGB, T == Bool {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b)
    }
}

extension Image where P == RGB, T == UInt8 {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b)
    }
}

extension Image where P == RGB, T == Int {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b)
    }
}

extension Image where P == RGB, T == Float {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b)
    }
}

extension Image where P == RGB, T == Double {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b)
    }
}

extension Image where P == RGBA, T == Bool {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b, a: a)
    }
}

extension Image where P == RGBA, T == UInt8 {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b, a: a)
    }
}

extension Image where P == RGBA, T == Int {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b, a: a)
    }
}

extension Image where P == RGBA, T == Float {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b, a: a)
    }
}

extension Image where P == RGBA, T == Double {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b, a: a)
    }
}

extension Image where P == ARGB, T == Bool {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(a: a, r: r, g: g, b: b)
    }
}

extension Image where P == ARGB, T == UInt8 {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(a: a, r: r, g: g, b: b)
    }
}

extension Image where P == ARGB, T == Int {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(a: a, r: r, g: g, b: b)
    }
}

extension Image where P == ARGB, T == Float {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(a: a, r: r, g: g, b: b)
    }
}

extension Image where P == ARGB, T == Double {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(a: a, r: r, g: g, b: b)
    }
}

