
import Foundation

extension Image {
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
    
    mutating func _fill(_ pixel: Pixel<P, T>) {
        let (width, height) = size
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
