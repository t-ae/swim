public enum IntegralImageConverter {
    /// Create integral image from input image.
    public static func convert<T: AdditiveArithmetic>(image: Image<Intensity, T>) -> Image<Intensity, T> {
        var newImage = image
        
        newImage.data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress! + 1
            
            // First row
            for _ in 1..<image.width {
                p.pointee += (p-1).pointee
                p += 1
            }
            
            // Rest rows
            var p2 = $0.baseAddress!
            for _ in 1..<image.height {
                var rowsum = T.zero
                
                for _ in 0..<image.width {
                    rowsum += p.pointee
                    p.pointee = p2.pointee + rowsum
                    p += 1
                    p2 += 1
                }
            }
        }
        
        return newImage
    }
}
