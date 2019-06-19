extension Image {
    /// Shift image.
    ///
    /// - Parameters:
    ///   - x: Horizontal offset amount.
    ///   - y: Vertical offset amount.
    ///   - edgeMode: Determine how to fill area outside image.
    @inlinable
    public func shifted(x: Int, y: Int, edgeMode: EdgeMode<P, T>) -> Image {
        return .createWithUnsafePixelRef(width: width, height: height) { ref in
            ref.setColor(x: ref.x - x, y: ref.y - y, in: self, edgeMode: edgeMode)
        }
    }
}
