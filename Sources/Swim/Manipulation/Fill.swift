import Foundation

extension Image {
    @inlinable
    public mutating func fill(_ value: T) {
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<$0.count {
                dst.pointee = value
                dst += 1
            }
        }
    }
    
    @inlinable
    public mutating func fill(_ pixel: Pixel<P, T>) {
        let (width, height) = size
        data.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for _ in 0..<width*height {
                memcpy(dst, pixel.data, P.channels*MemoryLayout<T>.size)
                dst += P.channels
            }
        }
    }
}
