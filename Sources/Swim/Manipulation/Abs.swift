import Foundation

extension Image where T: Comparable&SignedNumeric {
    @inlinable
    public mutating func abs() {
        channelwiseConvert(Swift.abs)
    }
    
    @inlinable
    public func formAbs() -> Image {
        var newImage = self
        newImage.abs()
        return newImage
    }
}
