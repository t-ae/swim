
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
            return self.getChannel(channel: channel)
        }
        set {
            precondition(0 <= channel && channel <= P.channels)
            self.setChannel(channel: channel, newValue: newValue)
        }
    }
    
    public subscript(channel channel: P) -> Image<Intensity, T> {
        get {
            return self.getChannel(channel: channel.rawValue)
        }
        set {
            self.setChannel(channel: channel.rawValue, newValue: newValue)
        }
    }
}
