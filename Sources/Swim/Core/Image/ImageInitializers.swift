extension Image where P == Gray {
    @inlinable
    public init(width: Int, height: Int, gray: [T]) {
        self.init(width: width, height: height, data: gray)
    }
}

extension Image where P == GrayAlpha {
    @inlinable
    public init(width: Int, height: Int, grayAlpha: [T]) {
        self.init(width: width, height: height, data: grayAlpha)
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
