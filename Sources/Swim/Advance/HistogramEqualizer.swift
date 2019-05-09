import Foundation

public enum HistogramEqualizer<T: BinaryInteger&DataType> {
    /// Create histogram equalized image.
    /// This function assumes pixel value range is [0, 255].
    public static func equalize(image: Image<Intensity, T>) -> Image<Intensity, T> {
        var bins = [Int](repeating: 0, count: Int(UInt8.max))
        for px in image.data {
            bins[Int(px)] += 1
        }
        
        var cumsum = bins
        for i in 1..<cumsum.count {
            cumsum[i] += cumsum[i-1]
        }
        
        let scale = cumsum.last!
        
        var newImage = image
        
        newImage.channelwiseConvert { px in
            T(Int(UInt8.max) * cumsum[Int(px)] / scale)
        }
        
        return newImage
    }
}
