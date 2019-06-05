extension Image where T == Bool {
    @inlinable
    public func hasTrue() -> Bool {
        for b in data {
            if b {
                return true
            }
        }
        return false
    }
    
    @inlinable
    public func hasFalse() -> Bool {
        for b in data {
            if !b {
                return true
            }
        }
        return false
    }
    
    @inlinable
    public func allTrue() -> Bool {
        for b in data {
            if !b {
                return false
            }
        }
        return true
    }
    
    @inlinable
    public func allFalse() -> Bool {
        for b in data {
            if b {
                return false
            }
        }
        return true
    }
}
