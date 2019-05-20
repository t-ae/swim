import Foundation

extension Image where T: Comparable&SignedNumeric {
    @inlinable
    public mutating func applyAbs() {
        channelwiseConvert(Swift.abs)
    }
    
    @inlinable
    public func abs() -> Image {
        var newImage = self
        newImage.applyAbs()
        return newImage
    }
}
