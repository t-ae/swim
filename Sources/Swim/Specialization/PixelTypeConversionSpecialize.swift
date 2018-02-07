
extension Image where P == Intensity, T == Bool {
    public func toRGB() -> Image<RGB, T> {
        return _toRGB()
    }
}

extension Image where P == Intensity, T == UInt8 {
    public func toRGB() -> Image<RGB, T> {
        return _toRGB()
    }
}

extension Image where P == Intensity, T == Int {
    public func toRGB() -> Image<RGB, T> {
        return _toRGB()
    }
}

extension Image where P == Intensity, T == Float {
    public func toRGB() -> Image<RGB, T> {
        return _toRGB()
    }
}

extension Image where P == Intensity, T == Double {
    public func toRGB() -> Image<RGB, T> {
        return _toRGB()
    }
}


extension Image where P == RGB, T == Int {
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    public func toLuminance() -> Image<Intensity, T> {
        return _toLuminance()
    }
}

extension Image where P == RGB, T == Float {
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    public func toLuminance() -> Image<Intensity, T> {
        return _toLuminance()
    }
}

extension Image where P == RGB, T == Double {
    public func toBrightness() -> Image<Intensity, T> {
        return _toBrightness()
    }
    
    public func toLuminance() -> Image<Intensity, T> {
        return _toLuminance()
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



extension Image where P == RGBA, T == Bool {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toARGB() -> Image<ARGB, T> {
        let data = permuteChannels(data: self.data, permutation: [3, 0, 1, 2])
        return Image<ARGB, T>(width: width, height: height, argb: data)
    }
}

extension Image where P == ARGB, T == Bool  {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toRGBA() -> Image<RGBA, T> {
        let data = permuteChannels(data: self.data, permutation: [1, 2, 3, 0])
        return Image<RGBA, T>(width: width, height: height, rgba: data)
    }
}


extension Image where P == RGBA, T == UInt8 {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toARGB() -> Image<ARGB, T> {
        let data = permuteChannels(data: self.data, permutation: [3, 0, 1, 2])
        return Image<ARGB, T>(width: width, height: height, argb: data)
    }
}

extension Image where P == ARGB, T == UInt8  {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toRGBA() -> Image<RGBA, T> {
        let data = permuteChannels(data: self.data, permutation: [1, 2, 3, 0])
        return Image<RGBA, T>(width: width, height: height, rgba: data)
    }
}


extension Image where P == RGBA, T == Int {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toARGB() -> Image<ARGB, T> {
        let data = permuteChannels(data: self.data, permutation: [3, 0, 1, 2])
        return Image<ARGB, T>(width: width, height: height, argb: data)
    }
}

extension Image where P == ARGB, T == Int  {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toRGBA() -> Image<RGBA, T> {
        let data = permuteChannels(data: self.data, permutation: [1, 2, 3, 0])
        return Image<RGBA, T>(width: width, height: height, rgba: data)
    }
}


extension Image where P == RGBA, T == Float {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toARGB() -> Image<ARGB, T> {
        let data = permuteChannels(data: self.data, permutation: [3, 0, 1, 2])
        return Image<ARGB, T>(width: width, height: height, argb: data)
    }
}

extension Image where P == ARGB, T == Float  {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toRGBA() -> Image<RGBA, T> {
        let data = permuteChannels(data: self.data, permutation: [1, 2, 3, 0])
        return Image<RGBA, T>(width: width, height: height, rgba: data)
    }
}


extension Image where P == RGBA, T == Double {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toARGB() -> Image<ARGB, T> {
        let data = permuteChannels(data: self.data, permutation: [3, 0, 1, 2])
        return Image<ARGB, T>(width: width, height: height, argb: data)
    }
}

extension Image where P == ARGB, T == Double  {
    public func toRGB() -> Image<RGB, T> {
        return removeAlpha(image: self)
    }

    public func toRGBA() -> Image<RGBA, T> {
        let data = permuteChannels(data: self.data, permutation: [1, 2, 3, 0])
        return Image<RGBA, T>(width: width, height: height, rgba: data)
    }
}

