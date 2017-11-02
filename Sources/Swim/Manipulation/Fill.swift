
import Foundation

extension Image where P == Intensity {
    mutating func _fill(_ value: T) {
        for i in 0..<data.count {
            data[i] = value
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
