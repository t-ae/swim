
func clamp<T: Comparable>(_ value: T, min: T, max: T) -> T {
    guard value > min else {
        return min
    }
    guard value < max else {
        return max
    }
    return value
}
