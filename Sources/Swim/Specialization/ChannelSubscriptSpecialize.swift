
// FIXME: Wait for Swift4
/*
extension Image where P == Intensity, T == Bool {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Float {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == Intensity, T == Double {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Bool {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Float {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGB, T == Double {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Bool {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Float {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == RGBA, T == Double {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Bool {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == UInt8 {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Int {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Float {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

extension Image where P == ARGB, T == Double {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(channel: channel.rawValue)
        }
        set {
            setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}

*/