
import Foundation

extension Image where T: FloatingPoint {
    mutating func _round() {
        channelwiseConvert(Foundation.round)
    }
    
    public mutating func round() {
        _round()
    }
    
    public func rounded() -> Image<P, T> {
        var newImage = self
        newImage._round()
        return newImage
    }
    
    mutating func _ceil() {
        channelwiseConvert(Foundation.ceil)
    }
    
    public mutating func ceil() {
        _ceil()
    }
    
    public func ceiled() -> Image<P, T> {
        var newImage = self
        newImage._ceil()
        return newImage
    }
    
    mutating func _floor() {
        channelwiseConvert(Foundation.floor)
    }
    
    public mutating func floor() {
        _floor()
    }
    
    public func floored() -> Image<P, T> {
        var newImage = self
        newImage._floor()
        return newImage
    }
}

#if os(macOS) || os(iOS)
    import Accelerate
    
    extension Image where T == Float {
        mutating func _round() {
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                var count = Int32($0.count)
                vvnintf(p, p, &count)
            }
        }
        
        mutating func _ceil() {
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                var count = Int32($0.count)
                vvceilf(p, p, &count)
            }
        }
        
        mutating func _floor() {
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                var count = Int32($0.count)
                vvfloorf(p, p, &count)
            }
        }
    }
    
    extension Image where T == Double {
        mutating func _round() {
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                var count = Int32($0.count)
                vvnint(p, p, &count)
            }
        }
        
        mutating func _ceil() {
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                var count = Int32($0.count)
                vvceil(p, p, &count)
            }
        }
        
        mutating func _floor() {
            data.withUnsafeMutableBufferPointer {
                let p = $0.baseAddress!
                var count = Int32($0.count)
                vvfloor(p, p, &count)
            }
        }
    }
#endif
