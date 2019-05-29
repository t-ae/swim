import Foundation

extension Image where T: FloatingPoint {
    @inlinable
    public mutating func applyRound() {
        dataConvert(Foundation.round)
    }
    
    @inlinable
    public func round() -> Image<P, T> {
        return dataConverted(Foundation.round)
    }
    
    @inlinable
    public mutating func applyCeil() {
        dataConvert(Foundation.ceil)
    }

    @inlinable
    public func ceil() -> Image<P, T> {
        return dataConverted(Foundation.ceil)
    }
    
    @inlinable
    public mutating func applyFloor() {
        dataConvert(Foundation.floor)
    }
    
    @inlinable
    public func floor() -> Image<P, T> {
        return dataConverted(Foundation.floor)
    }
    
    @inlinable
    public mutating func applyTrunc() {
        dataConvert(Foundation.trunc)
    }
    
    @inlinable
    public func trunc() -> Image<P, T> {
        return dataConverted(Foundation.trunc)
    }
}
