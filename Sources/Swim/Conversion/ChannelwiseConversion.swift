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
    ///
    /// - Note: If you don't need x, y, channel information, using `dataConvert` is faster.
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
    
    /// Convert pixel values.
    ///
    /// Closure takes 4 arguments, x, y, channel, value. And returns new value.
    ///
    /// - Note: If you don't need x, y, channel information, using `dataConverted` is faster.
    @inlinable
    public func channelwiseConverted<T2>(_ body: ChannelwiseConversion<P, T, T2>) -> Image<P, T2> {
        return channelwiseConverted(0..<width, 0..<height, body)
    }
    
    /// Convert pixel values in specified range.
    ///
    /// Closure takes 4 arguments, x, y, channel, value. And returns new value.
    ///
    /// - Note: If you don't need x, y, channel information, using `dataConverted` is faster.
    @inlinable
    public func channelwiseConverted<T2>(_ xRange: Range<Int>,
                                         _ yRange: Range<Int>,
                                         _ body: ChannelwiseConversion<P, T, T2>) -> Image<P, T2> {
        var newImage = Image<P, T2>(width: width, height: height)
        
        var start = dataIndex(x: xRange.startIndex, y: yRange.startIndex)
        for y in 0..<height {
            var i = start
            for x in 0..<width {
                for c in 0..<P.channels {
                    newImage.data[i] = body(x, y, P(rawValue: c)!, data[i])
                    i += 1
                }
            }
            start += width*P.channels
        }
        
        return newImage
    }
}


