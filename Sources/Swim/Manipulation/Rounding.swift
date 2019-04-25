import Foundation

extension Image where T: FloatingPoint {
    @inlinable
    public mutating func round() {
        channelwiseConvert(Foundation.round)
    }
    
    @inlinable
    public func rounded() -> Image<P, T> {
        var newImage = self
        newImage.round()
        return newImage
    }
    
    @inlinable
    public mutating func ceil() {
        channelwiseConvert(Foundation.ceil)
    }

    @inlinable
    public func ceiled() -> Image<P, T> {
        var newImage = self
        newImage.ceil()
        return newImage
    }
    
    @inlinable
    public mutating func floor() {
        channelwiseConvert(Foundation.floor)
    }
    
    @inlinable
    public func floored() -> Image<P, T> {
        var newImage = self
        newImage.floor()
        return newImage
    }
}

#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

extension Image where T == Float {
    @inlinable
    public mutating func round() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            var count = Int32($0.count)
            vvnintf(p, p, &count)
        }
    }
    
    @inlinable
    public func rounded() -> Image<P, T> {
        var newImage = self
        newImage.round()
        return newImage
    }
    
    @inlinable
    public mutating func ceil() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            var count = Int32($0.count)
            vvceilf(p, p, &count)
        }
    }
    
    @inlinable
    public func ceiled() -> Image<P, T> {
        var newImage = self
        newImage.ceil()
        return newImage
    }
    
    @inlinable
    public mutating func floor() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            var count = Int32($0.count)
            vvfloorf(p, p, &count)
        }
    }
    
    @inlinable
    public func floored() -> Image<P, T> {
        var newImage = self
        newImage.floor()
        return newImage
    }
}

extension Image where T == Double {
    @inlinable
    public mutating func round() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            var count = Int32($0.count)
            vvnint(p, p, &count)
        }
    }
    
    @inlinable
    public func rounded() -> Image<P, T> {
        var newImage = self
        newImage.round()
        return newImage
    }
    
    @inlinable
    public mutating func ceil() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            var count = Int32($0.count)
            vvceil(p, p, &count)
        }
    }
    
    @inlinable
    public func ceiled() -> Image<P, T> {
        var newImage = self
        newImage.ceil()
        return newImage
    }
    
    @inlinable
    public mutating func floor() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            var count = Int32($0.count)
            vvfloor(p, p, &count)
        }
    }
    
    @inlinable
    public func floored() -> Image<P, T> {
        var newImage = self
        newImage.floor()
        return newImage
    }
}

#endif
