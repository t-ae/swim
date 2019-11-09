public enum IntegralImageConverter {
    /// Create integral image from input image.
    @inlinable
    public static func convert<T: BinaryInteger>(image: Image<Gray, T>) -> Image<Gray, Int> {
        return .createWithUnsafeMutableBufferPointer(width: image.width, height: image.height) { bp in
            // First row
            var p = bp.baseAddress!
            do {
                var rowsum = 0
                for i in 0..<image.width {
                    rowsum += Int(image.data[i])
                    p.initialize(to: rowsum)
                    p += 1
                }
            }
            
            // Rest rows
            for i in stride(from: image.width, to: image.data.count, by: image.width) {
                var rowsum = 0
                for x in 0..<image.width {
                    rowsum += Int(image.data[i+x])
                    
                    p.initialize(to: rowsum + bp[i+x-image.width])
                    p += 1
                }
            }
        }
    }
    
    /// Create integral image from input image.
    @inlinable
    public static func convert<T: FloatingPoint>(image: Image<Gray, T>) -> Image<Gray, T> {
        return .createWithUnsafeMutableBufferPointer(width: image.width, height: image.height) { bp in
            // First row
            var p = bp.baseAddress!
            do {
                var rowsum = T.zero
                for i in 0..<image.width {
                    rowsum += image.data[i]
                    p.initialize(to: rowsum)
                    p += 1
                }
            }
            
            // Rest rows
            for i in stride(from: image.width, to: image.data.count, by: image.width) {
                var rowsum = T.zero
                for x in 0..<image.width {
                    rowsum += image.data[i+x]
                    p.initialize(to: rowsum + bp[i+x-image.width])
                    p += 1
                }
            }
        }
    }
}
