import Foundation

extension Image where T: FloatingPoint {
    @inlinable
    public mutating func round() {
        channelwiseConvert(Foundation.round)
    }
    
    @inlinable
    public func rounded() -> Image<P, T> {
        var newImage = self
        newImage.round()
        return newImage
    }
    
    @inlinable
    public mutating func ceil() {
        channelwiseConvert(Foundation.ceil)
    }

    @inlinable
    public func ceiled() -> Image<P, T> {
        var newImage = self
        newImage.ceil()
        return newImage
    }
    
    @inlinable
    public mutating func floor() {
        channelwiseConvert(Foundation.floor)
    }
    
    @inlinable
    public func floored() -> Image<P, T> {
        var newImage = self
        newImage.floor()
        return newImage
    }
}
