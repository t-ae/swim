extension Array where Element: Comparable {
    @inlinable
    func minIndex() -> Int? {
        guard let minValue = self.min() else {
            return nil
        }
        return firstIndex(of: minValue)
    }
    
    @inlinable
    func maxIndex() -> Int? {
        guard let maxValue = self.max() else {
            return nil
        }
        return firstIndex(of: maxValue)
    }
}

extension Array where Element: Comparable {
    @inlinable
    func median() -> Element? {
        guard count > 0 else {
            return nil
        }
        let s = sorted()
        return s[(count-1)/2]
    }
    
    @inlinable
    func medianIndex() -> Int? {
        guard let medianValue = median() else {
            return nil
        }
        return firstIndex(of: medianValue)
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
