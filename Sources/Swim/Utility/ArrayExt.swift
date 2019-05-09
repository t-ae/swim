extension Array where Element: Comparable {
    @inlinable
    func median() -> Element? {
        guard count > 0 else {
            return nil
        }
        let s = sorted()
        return s[(count-1)/2]
    }
}
