
private func getChannel<P, T>(image: Image<P, T>, channel: Int) ->Image<Intensity, T> {
    return image.converted { _, _, px in px.data[channel] }
}

private func setChannel<P, T>(image: inout Image<P, T>, channel: Int, newValue: Image<Intensity, T>) {
    image.data.withUnsafeMutableBufferPointer {
        var dst = $0.baseAddress! + channel
        for v in newValue.data {
            dst.pointee = v
            dst += P.channels
        }
    }
}

extension Image {
    public subscript(channel channel: Int) -> Image<Intensity, T> {
        get{
            precondition(0 <= channel && channel <= P.channels)
            return getChannel(image: self, channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            setChannel(image: &self, channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return getChannel(image: self, channel: channel.rawValue)
        }
        set {
            setChannel(image: &self, channel: channel.rawValue, newValue: newValue)
        }
    }
}
