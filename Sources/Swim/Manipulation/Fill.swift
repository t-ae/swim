
import Foundation

extension Image where P == Intensity {
    mutating func _fill(_ value: T) {
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<$0.count {
                dst.pointee = value
                dst += 1
            }
        }
    }
    
    public mutating func fill(_ value: T) {
        _fill(value)
    }
}

extension Image {
    mutating func _fill(_ pixel: Pixel<P, T>) {
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<width*height {
                memcpy(dst, pixel.data, P.channels*MemoryLayout<T>.size)
                dst += P.channels
            }
        }
    }
    
    public mutating func fill(_ pixel: Pixel<P, T>) {
        _fill(pixel)
    }
}
