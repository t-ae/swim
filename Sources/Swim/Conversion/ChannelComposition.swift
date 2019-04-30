import Foundation

extension Image where P == IntensityAlpha {
    @inlinable
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        precondition(intensity.size == alpha.size, "Images must have same size.")
        
        let (width, height) = intensity.size
        let data = interleave(data1: intensity.data, data2: alpha.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGB {
    @inlinable
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(r.size == g.size && g.size == b.size, "Images must have same size.")
        
        let (width, height) = r.size
        let data = interleave(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA {
    @inlinable
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        precondition(r.size == g.size && g.size == b.size && b.size == a.size, "Images must have same size.")
        
        let (width, height) = r.size
        let data = interleave(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == ARGB {
    @inlinable
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(a.size == r.size && r.size == g.size && g.size == b.size, "Images must have same size.")
        
        let (width, height) = r.size
        let data = interleave(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}
