
extension Image where P == RGB, T == Float {
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    public func toLuminane() -> Image<Intensity, T> {
        return _toLuminane()
    }
}

extension Image where P == RGB, T == Double {
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    public func toLuminane() -> Image<Intensity, T> {
        return _toLuminane()
    }
}


extension Image where P == RGBA, T == UInt8 {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }

    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 255)
    }
}

extension Image where P == RGBA, T == Int {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }

    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 255)
    }
}


extension Image where P == RGBA, T == Float {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
    
    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 1)
    }
}

extension Image where P == RGBA, T == Double {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
    
    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 1)
    }
}


extension Image where P == ARGB, T == UInt8 {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }

    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 255)
    }
}

extension Image where P == ARGB, T == Int {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }

    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 255)
    }
}


extension Image where P == ARGB, T == Float {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
    
    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 1)
    }
}

extension Image where P == ARGB, T == Double {
    public init(image: Image<RGB, T>, alpha: T) {
        self = imageFromRGB(image: image, alpha: alpha)
    }
    
    public init(image: Image<RGB, T>) {
        self = imageFromRGB(image: image, alpha: 1)
    }
}


extension Image where P == RGB, T == UInt8 {
    public init(image: Image<RGBA, T>) {
        self = imageFromRGBA(image: image)
    }
}

extension Image where P == RGB, T == Int {
    public init(image: Image<RGBA, T>) {
        self = imageFromRGBA(image: image)
    }
}

extension Image where P == RGB, T == Float {
    public init(image: Image<RGBA, T>) {
        self = imageFromRGBA(image: image)
    }
}

extension Image where P == RGB, T == Double {
    public init(image: Image<RGBA, T>) {
        self = imageFromRGBA(image: image)
    }
}

