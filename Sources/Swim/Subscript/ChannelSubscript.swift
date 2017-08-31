
extension Image {
    func getChannel(channel: Int) ->Image<Intensity, T> {
        return converted { _, _, px in px.data[channel] }
    }
    
    mutating func setChannel(channel: Int, newValue: Image<Intensity, T>) {
        self.unsafeChannelwiseConvert {
            var dst = $0.baseAddress! + channel
            for v in newValue.data {
                dst.pointee = v
                dst += P.channels
            }
        }
    }
    
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
