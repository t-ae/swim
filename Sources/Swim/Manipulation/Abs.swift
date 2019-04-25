import Foundation

extension Image where T: Comparable&SignedNumeric {
    @inlinable
    public mutating func abs() {
        channelwiseConvert(Swift.abs)
    }
    
    @inlinable
    public func formAbs() -> Image {
        var newImage = self
        newImage.abs()
        return newImage
    }
}

#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

extension Image where T == Float {
    @inlinable
    public mutating func abs() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            vDSP_vabs(p, 1, p, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public func formAbs() -> Image {
        var newImage = self
        newImage.abs()
        return newImage
    }
}

extension Image where T == Double {
    @inlinable
    public mutating func abs() {
        data.withUnsafeMutableBufferPointer {
            let p = $0.baseAddress!
            vDSP_vabsD(p, 1, p, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public func formAbs() -> Image {
        var newImage = self
        newImage.abs()
        return newImage
    }
}

#endif
