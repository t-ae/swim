import Foundation

extension Image where T: FloatingPoint {
    @inlinable
    public mutating func applyRound() {
        channelwiseConvert(Foundation.round)
    }
    
    @inlinable
    public func round() -> Image<P, T> {
        var newImage = self
        newImage.applyRound()
        return newImage
    }
    
    @inlinable
    public mutating func applyCeil() {
        channelwiseConvert(Foundation.ceil)
    }

    @inlinable
    public func ceil() -> Image<P, T> {
        var newImage = self
        newImage.applyCeil()
        return newImage
    }
    
    @inlinable
    public mutating func applyFloor() {
        channelwiseConvert(Foundation.floor)
    }
    
    @inlinable
    public func floor() -> Image<P, T> {
        var newImage = self
        newImage.applyFloor()
        return newImage
    }
    
    @inlinable
    public mutating func applyTrunc() {
        channelwiseConvert(Foundation.trunc)
    }
    
    @inlinable
    public func trunc() -> Image<P, T> {
        var newImage = self
        newImage.applyTrunc()
        return newImage
    }
}
