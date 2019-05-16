import Foundation

// FIXME: Float/Double versions are implemented separately.
// They'll be unified in Swift 5.1.
// https://github.com/apple/swift-evolution/blob/master/proposals/0246-mathable.md

extension Image where T == Float {
    @inlinable
    public mutating func power(_ exponent: T) {
        channelwiseConvert { px in
            pow(px, exponent)
        }
    }
    
    @inlinable
    public func powered(_ exponential: T) -> Image<P, T> {
        var newImage = self
        newImage.power(exponential)
        return newImage
    }
}

extension Image where T == Double {
    @inlinable
    public mutating func power(_ exponent: T){
        channelwiseConvert { px in
            pow(px, exponent)
        }
    }
    
    @inlinable
    public func powered(_ exponential: T) -> Image<P, T> {
        var newImage = self
        newImage.power(exponential)
        return newImage
    }
}
