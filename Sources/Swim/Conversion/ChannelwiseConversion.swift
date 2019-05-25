public typealias ChannelwiseConversion<P, T, T2> = (_ x: Int, _ y: Int, _ c: P, _ value: T) -> T2

extension Image {
    /// Convert pixel values.
    ///
    /// Closure takes 4 arguments, x, y, channel, value. And returns new value.
    ///
    /// - Note: If you don't need x, y, channel information, using `dataConvert` is faster.
    @inlinable
    public mutating func channelwiseConvert(_ body: ChannelwiseConversion<P, T, T>) {
        channelwiseConvert(0..<width, 0..<height, body)
    }
    
    /// Convert pixel values in specified range.
    ///
    /// Closure takes 4 arguments, x, y, channel, value. And returns new value.
    @inlinable
    public mutating func channelwiseConvert(_ xRange: Range<Int>,
                                            _ yRange: Range<Int>,
                                            _ body: ChannelwiseConversion<P, T, T>) {
        var start = dataIndex(x: xRange.startIndex, y: yRange.startIndex)
        for y in yRange {
            var i = start
            for x in xRange {
                for c in 0..<P.channels {
                    data[i] = body(x, y, P(rawValue: c)!, data[i])
                    i += 1
                }
            }
            start += width*P.channels
        }
    }
    
    /// Convert pixel values of specified channel.
    ///
    /// Closure takes 3 arguments, x, y, value. And returns new value.
    @inlinable
    public mutating func channelwiseConvert(channel: P, _ body: (_ x: Int, _ y: Int, _ value: T) -> T) {
        channelwiseConvert(0..<width, 0..<height, channel, body)
    }
    
    /// Convert pixel values of specified channel/range.
    ///
    /// Closure takes 3 arguments, x, y, value. And returns new value.
    @inlinable
    public mutating func channelwiseConvert(_ xRange: Range<Int>,
                                            _ yRange: Range<Int>,
                                            _ channel: P,
                                            _ body: (_ x: Int, _ y: Int, _ value: T) -> T) {
        var start = dataIndex(x: xRange.startIndex, y: yRange.startIndex, c: channel.rawValue)
        for y in yRange {
            var i = start
            for x in xRange {
                data[i] = body(x, y, data[i])
                i += P.channels
            }
            start += width*P.channels
        }
    }
    
    /// Convert pixel values.
    ///
    /// Closure takes 4 arguments, x, y, channel, value. And returns new value.
    ///
    /// - Note: If you don't need x, y, channel information, using `dataConverted` is faster.
    @inlinable
    public func channelwiseConverted<T2>(_ body: ChannelwiseConversion<P, T, T2>) -> Image<P, T2> {
        var newImage = Image<P, T2>(width: width, height: height)
        
        var i = 0
        for y in 0..<height {
            for x in 0..<width {
                for c in 0..<P.channels {
                    newImage.data[i] = body(x, y, P(rawValue: c)!, data[i])
                    i += 1
                }
            }
        }
        
        return newImage
    }
}


