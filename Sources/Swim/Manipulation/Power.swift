import Foundation

// FIXME: Float/Double versions are implemented separately.
// They'll be unified in Swift 5.1.
// https://github.com/apple/swift-evolution/blob/master/proposals/0246-mathable.md

extension Image where T == Float {
    @inlinable
    public mutating func applyPow(_ exponent: T){
        for i in 0..<data.count {
            data[i] = Foundation.pow(data[i], exponent)
        }
    }
    
    @inlinable
    public func pow(_ exponent: T) -> Image<P, T> {
        return dataConverted {
            Foundation.pow($0, exponent)
        }
    }
}

extension Image where T == Double {
    @inlinable
    public mutating func applyPow(_ exponent: T){
        for i in 0..<data.count {
            data[i] = Foundation.pow(data[i], exponent)
        }
    }
    
    @inlinable
    public func pow(_ exponent: T) -> Image<P, T> {
        return dataConverted {
            Foundation.pow($0, exponent)
        }
    }
}
