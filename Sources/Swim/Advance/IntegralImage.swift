public enum IntegralImageConverter {
    /// Create integral image from input image.
    @inlinable
    public static func convert<T: BinaryInteger>(image: Image<Intensity, T>) -> Image<Intensity, Int> {
        var newImage = Image<Intensity, Int>.zeros(like: image)
        
        // First row
        do {
            var rowsum = 0
            for i in 0..<image.width {
                rowsum += Int(image.data[i])
                newImage.data[i] = rowsum
            }
        }
        
        // Rest rows
        for i in stride(from: image.width, to: image.data.count, by: image.width) {
            var rowsum = 0
            for x in 0..<image.width {
                rowsum += Int(image.data[i+x])
                newImage.data[i+x] = rowsum + newImage.data[i+x-newImage.width]
            }
        }
        
        return newImage
    }
    
    /// Create integral image from input image.
    @inlinable
    public static func convert<T: FloatingPoint>(image: Image<Intensity, T>) -> Image<Intensity, T> {
        var newImage = Image.zeros(like: image)
        
        // First row
        do {
            var rowsum = T.zero
            for i in 0..<image.width {
                rowsum += image.data[i]
                newImage.data[i] = rowsum
            }
        }
        
        // Rest rows
        for i in stride(from: image.width, to: image.data.count, by: image.width) {
            var rowsum = T.zero
            for x in 0..<image.width {
                rowsum += image.data[i+x]
                newImage.data[i+x] = rowsum + newImage.data[i+x-newImage.width]
            }
        }
        
        return newImage
    }
}
