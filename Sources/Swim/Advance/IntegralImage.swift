public enum IntegralImageConverter {
    /// Create integral image from input image.
    @inlinable
    public static func convert<T: BinaryInteger>(image: Image<Gray, T>) -> Image<Gray, Int> {
        return .createWithUnsafeMutableBufferPointer(width: image.width, height: image.height) { bp in
            // First row
            do {
                var rowsum = 0
                for i in 0..<image.width {
                    rowsum += Int(image.data[i])
                    bp[i] = rowsum
                }
            }
            
            // Rest rows
            for i in stride(from: image.width, to: image.data.count, by: image.width) {
                var rowsum = 0
                for x in 0..<image.width {
                    rowsum += Int(image.data[i+x])
                    bp[i+x] = rowsum + bp[i+x-image.width]
                }
            }
        }
    }
    
    /// Create integral image from input image.
    @inlinable
    public static func convert<T: FloatingPoint>(image: Image<Gray, T>) -> Image<Gray, T> {
        return .createWithUnsafeMutableBufferPointer(width: image.width, height: image.height) { bp in
            // First row
            do {
                var rowsum = T.zero
                for i in 0..<image.width {
                    rowsum += image.data[i]
                    bp[i] = rowsum
                }
            }
            
            // Rest rows
            for i in stride(from: image.width, to: image.data.count, by: image.width) {
                var rowsum = T.zero
                for x in 0..<image.width {
                    rowsum += image.data[i+x]
                    bp[i+x] = rowsum + bp[i+x-image.width]
                }
            }
        }
    }
}
