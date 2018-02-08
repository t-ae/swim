
func clamp<T: Comparable>(_ value: T, min: T, max: T) -> T {
    assert(min<max)
    
    guard value > min else {
        return min
    }
    guard value < max else {
        return max
    }
    return value
}
