import Foundation

extension Image {
    @inlinable
    public mutating func fill(_ value: T) {
        for i in 0..<data.count {
            data[i] = value
        }
    }
    
    @inlinable
    public mutating func fill(_ pixel: Pixel<P, T>) {
        for i in stride(from: 0, to: data.count, by: P.channels) {
            for c in 0..<P.channels {
                data[c+i] = pixel.data[c]
            }
        }
    }
}
