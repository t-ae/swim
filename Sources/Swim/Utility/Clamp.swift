/// Returns the median value of given arguments.
/// if `value` is NaN, it return NaN.
@inlinable
func clamp<T: Comparable>(_ value: T, min: T, max: T) -> T {
    assert(min<=max)
    
    if value <= min {
        return min
    } else if value >= max {
        return max
    } else {
        return value
    }
}
