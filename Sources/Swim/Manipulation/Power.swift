import Foundation

// FIXME: Float/Double versions are implemented separately.
// They'll be unified in Swift 5.1.
// https://github.com/apple/swift-evolution/blob/master/proposals/0246-mathable.md

extension Image where T == Float {
    @inlinable
    public mutating func power(_ exponent: T) {
        for i in 0..<data.count {
            data[i] = pow(data[i], exponent)
        }
    }
    
    @inlinable
    public func powered(_ exponent: T) -> Image<P, T> {
        return dataConverted {
            pow($0, exponent)
        }
    }
}

extension Image where T == Double {
    @inlinable
    public mutating func power(_ exponent: T){
        for i in 0..<data.count {
            data[i] = pow(data[i], exponent)
        }
    }
    
    @inlinable
    public func powered(_ exponent: T) -> Image<P, T> {
        return dataConverted {
            pow($0, exponent)
        }
    }
}
