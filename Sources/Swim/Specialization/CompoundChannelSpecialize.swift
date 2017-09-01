
extension Image where P == RGB, T == Bool {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width)
        precondition(r.height == g.height && g.height == b.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGB, T == UInt8 {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width)
        precondition(r.height == g.height && g.height == b.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGB, T == Int {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width)
        precondition(r.height == g.height && g.height == b.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGB, T == Float {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width)
        precondition(r.height == g.height && g.height == b.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGB, T == Double {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width)
        precondition(r.height == g.height && g.height == b.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA, T == Bool {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width && b.width == a.width)
        precondition(r.height == g.height && g.height == b.height && b.height == a.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA, T == UInt8 {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width && b.width == a.width)
        precondition(r.height == g.height && g.height == b.height && b.height == a.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA, T == Int {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width && b.width == a.width)
        precondition(r.height == g.height && g.height == b.height && b.height == a.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA, T == Float {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width && b.width == a.width)
        precondition(r.height == g.height && g.height == b.height && b.height == a.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA, T == Double {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width && b.width == a.width)
        precondition(r.height == g.height && g.height == b.height && b.height == a.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == ARGB, T == Bool {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(a.width == r.width && r.width == g.width && g.width == b.width)
        precondition(a.height == r.height && r.height == g.height && g.height == b.height)
        
        let width = a.width
        let height = a.height
        let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == ARGB, T == UInt8 {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(a.width == r.width && r.width == g.width && g.width == b.width)
        precondition(a.height == r.height && r.height == g.height && g.height == b.height)
        
        let width = a.width
        let height = a.height
        let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == ARGB, T == Int {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(a.width == r.width && r.width == g.width && g.width == b.width)
        precondition(a.height == r.height && r.height == g.height && g.height == b.height)
        
        let width = a.width
        let height = a.height
        let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == ARGB, T == Float {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(a.width == r.width && r.width == g.width && g.width == b.width)
        precondition(a.height == r.height && r.height == g.height && g.height == b.height)
        
        let width = a.width
        let height = a.height
        let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == ARGB, T == Double {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(a.width == r.width && r.width == g.width && g.width == b.width)
        precondition(a.height == r.height && r.height == g.height && g.height == b.height)
        
        let width = a.width
        let height = a.height
        let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

