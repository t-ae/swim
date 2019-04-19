import Foundation

@inlinable
func compoundChannels<T>(intensity: Image<Intensity, T>,
                         alpha: Image<Intensity, T>) -> Image<IntensityAlpha, T> {
    precondition(intensity.size == alpha.size, "Images must have same size.")
    
    let width = intensity.width
    let height = alpha.height
    let data = interleave(data1: intensity.data, data2: alpha.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels<T>(r: Image<Intensity, T>,
                         g: Image<Intensity, T>,
                         b: Image<Intensity, T>) -> Image<RGB, T> {
    precondition(r.size == g.size && g.size == b.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = interleave(data1: r.data, data2: g.data, data3: b.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels<T>(r: Image<Intensity, T>,
                         g: Image<Intensity, T>,
                         b: Image<Intensity, T>,
                         a: Image<Intensity, T>) -> Image<RGBA, T> {
    precondition(r.size == g.size && g.size == b.size && b.size == a.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = interleave(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels<T>(a: Image<Intensity, T>,
                         r: Image<Intensity, T>,
                         g: Image<Intensity, T>,
                         b: Image<Intensity, T>) -> Image<ARGB, T> {
    precondition(a.size == r.size && r.size == g.size && g.size == b.size, "Images must have same size.")
    
    let width = a.width
    let height = a.height
    let data = interleave(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
    
    return Image(width: width, height: height, data: data)
}

extension Image where P == IntensityAlpha {
    @inlinable
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        self = compoundChannels(intensity: intensity, alpha: alpha)
    }
}

extension Image where P == RGB {
    @inlinable
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b)
    }
}

extension Image where P == RGBA {
    @inlinable
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b, a: a)
    }
}

extension Image where P == ARGB {
    @inlinable
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(a: a, r: r, g: g, b: b)
    }
}
