public enum IntegralImageConverter {
    /// Create integral image from input image.
    @inlinable
    public static func convert<T: AdditiveArithmetic>(image: Image<Intensity, T>) -> Image<Intensity, T> {
        var newImage = image
        
        // First row
        do {
            var rowsum = newImage.data[0]
            for i in 1..<newImage.width {
                rowsum += newImage.data[i]
                newImage.data[i] = rowsum
            }
        }
        
        // Rest rows
        for i in stride(from: newImage.width, to: newImage.data.count, by: newImage.width) {
            var rowsum = T.zero
            for x in 0..<image.width {
                rowsum += newImage.data[i+x]
                newImage.data[i+x] = rowsum + newImage.data[i+x-newImage.width]
            }
        }
        
        return newImage
    }
}
