extension Image where P == GrayAlpha {
    /// Create `Image<GrayAlpha, T>` from two `Gray` images.
    ///
    /// - Precondition: gray.size == alpha.size
    @inlinable
    public init(gray: Image<Gray, T>, alpha: Image<Gray, T>) {
        precondition(gray.size == alpha.size, "Images must have same size.")
        
        let (width, height) = gray.size
        let data = interleave(data1: gray.data, data2: alpha.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGB {
    /// Create `Image<RGB, T>` from three `Gray` images.
    ///
    /// - Precondition: r.size == g.size == b.size
    @inlinable
    public init(r: Image<Gray, T>, g: Image<Gray, T>, b: Image<Gray, T>) {
        precondition(r.size == g.size && g.size == b.size, "Images must have same size.")
        
        let (width, height) = r.size
        let data = interleave(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA {
    /// Create `Image<RGBA, T>` from four `Gray` images.
    ///
    /// - Precondition: r.size == g.size == b.size == a.size
    @inlinable
    public init(r: Image<Gray, T>, g: Image<Gray, T>, b: Image<Gray, T>, a: Image<Gray, T>) {
        precondition(r.size == g.size && g.size == b.size && b.size == a.size, "Images must have same size.")
        
        let (width, height) = r.size
        let data = interleave(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
    
    /// Create `Image<RGBA, T>` from `RGB` image and `Gray` image.
    ///
    /// - Precondition: rgb.size == a.size
    @inlinable
    public init(rgb: Image<RGB, T>,  a: Image<Gray, T>) {
        precondition(rgb.size == a.size, "Images must have same size.")

        self = .createWithUnsafeMutableBufferPointer(width: a.width, height: a.height) {
            var p = $0.baseAddress!
            for i in 0..<a.pixelCount {
                p.initialize(to: rgb.data[3*i + 0])
                p += 1
                p.initialize(to: rgb.data[3*i + 1])
                p += 1
                p.initialize(to: rgb.data[3*i + 2])
                p += 1
                p.initialize(to: a.data[i])
                p += 1
            }
        }
    }
}

extension Image where P == ARGB {
    /// Create `Image<ARGB, T>` from four `Gray` images.
    ///
    /// - Precondition: a.size == r.size == g.size == b.size
    @inlinable
    public init(a: Image<Gray, T>, r: Image<Gray, T>, g: Image<Gray, T>, b: Image<Gray, T>) {
        precondition(a.size == r.size && r.size == g.size && g.size == b.size, "Images must have same size.")
        
        let (width, height) = r.size
        let data = interleave(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
    
    /// Create `Image<ARGB, T>` from `RGB` image and `Gray` image.
    ///
    /// - Precondition: a.size == rgb.size
    @inlinable
    public init(a: Image<Gray, T>, rgb: Image<RGB, T>) {
        precondition(rgb.size == a.size, "Images must have same size.")

        self = .createWithUnsafeMutableBufferPointer(width: a.width, height: a.height) {
            var p = $0.baseAddress!
            for i in 0..<a.pixelCount {
                p.initialize(to: a.data[i])
                p += 1
                p.initialize(to: rgb.data[3*i + 0])
                p += 1
                p.initialize(to: rgb.data[3*i + 1])
                p += 1
                p.initialize(to: rgb.data[3*i + 2])
                p += 1
            }
        }
    }
}
