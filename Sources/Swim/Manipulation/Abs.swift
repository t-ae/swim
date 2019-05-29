import Foundation

extension Image where T: Comparable&SignedNumeric {
    @inlinable
    public mutating func applyAbs() {
        dataConvert(Swift.abs)
    }
    
    @inlinable
    public func abs() -> Image {
        return dataConverted(Swift.abs)
    }
}
