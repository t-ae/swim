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

extension Array {
    @inlinable
    func all(_ condition: (Element)->Bool) -> Bool {
        for e in self {
            guard condition(e) else {
                return false
            }
        }
        return true
    }
    
    @inlinable
    func some(_ condition: (Element)->Bool) -> Bool {
        for e in self {
            guard !condition(e) else {
                return true
            }
        }
        return false
    }
}
