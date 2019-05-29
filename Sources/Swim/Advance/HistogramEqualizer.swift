import Foundation

public enum HistogramEqualizer<T: BinaryInteger&DataType> {
    /// Create histogram equalized image.
    ///
    /// This function assumes pixel value range is [0, 255].
    @inlinable
    public static func equalize(image: Image<Gray, T>) -> Image<Gray, T> {
        var bins = [Int](repeating: 0, count: Int(UInt8.max)+1)
        for px in image.data {
            bins[Int(px)] += 1
        }
        
        var cumsum = bins
        for i in 1..<cumsum.count {
            cumsum[i] += cumsum[i-1]
        }
        
        let scale = cumsum.last!
        
        var newImage = image
        
        newImage.dataConvert { px in
            T(Int(UInt8.max) * cumsum[Int(px)] / scale)
        }
        
        return newImage
    }
    
    /// Create histogram equalized image.
    ///
    /// This function assumes pixel value range is [0, 255].
    @inlinable
    public static func equalize(image: Image<RGB, T>) -> Image<RGB, T> {
        var bins = [Int](repeating: 0, count: Int(UInt8.max)+1)
        
        // Histgram over all channels
        for e in image.data {
            bins[Int(e)] += 1
        }
        
        var cumsum = bins
        for i in 1..<cumsum.count {
            cumsum[i] += cumsum[i-1]
        }
        
        let scale = cumsum.last!
        
        var newImage = image
        
        newImage.dataConvert { px in
            T(Int(UInt8.max) * cumsum[Int(px)] / scale)
        }
        
        return newImage
    }
}
