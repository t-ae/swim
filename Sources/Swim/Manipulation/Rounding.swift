import Foundation

/// FIXME: Default rounding functions are slow now.
/// Provide faster version.
/// https://bugs.swift.org/browse/SR-8746

@inlinable
func round_<T: FloatingPoint>(_ x: T) -> T {
    if let x = x as? Float {
        return roundf(x) as! T
    } else if let x = x as? Double {
        return round(x) as! T
    } else {
        return round(x)
    }
}

@inlinable
func floor_<T: FloatingPoint>(_ x: T) -> T {
    if let x = x as? Float {
        return floorf(x) as! T
    } else if let x = x as? Double {
        return floor(x) as! T
    } else {
        return floor(x)
    }
}

@inlinable
func ceil_<T: FloatingPoint>(_ x: T) -> T {
    if let x = x as? Float {
        return ceilf(x) as! T
    } else if let x = x as? Double {
        return ceil(x) as! T
    } else {
        return ceil(x)
    }
}

@inlinable
func trunc_<T: FloatingPoint>(_ x: T) -> T {
    if let x = x as? Float {
        return truncf(x) as! T
    } else if let x = x as? Double {
        return trunc(x) as! T
    } else {
        return trunc(x)
    }
}

extension Image where T: FloatingPoint {
    @inlinable
    public mutating func applyRound() {
        dataConvert(round_)
    }
    
    @inlinable
    public func round() -> Image<P, T> {
        return dataConverted(round_)
    }
    
    @inlinable
    public mutating func applyCeil() {
        dataConvert(ceil_)
    }

    @inlinable
    public func ceil() -> Image<P, T> {
        return dataConverted(ceil_)
    }
    
    @inlinable
    public mutating func applyFloor() {
        dataConvert(floor_)
    }
    
    @inlinable
    public func floor() -> Image<P, T> {
        return dataConverted(floor_)
    }
    
    @inlinable
    public mutating func applyTrunc() {
        dataConvert(trunc_)
    }
    
    @inlinable
    public func trunc() -> Image<P, T> {
        return dataConverted(trunc_)
    }
}
