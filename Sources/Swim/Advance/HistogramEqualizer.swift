import Foundation

public enum Histograms<P: NoAlpha, T: DataType> {
}

extension Histograms where T: BinaryInteger {
    /// Compute histogram of given image.
    ///
    /// This function assumes pixel value range is [0, 255].
    ///
    /// - Returns: Array of 256 elements.
    /// `array[i]` represents the number of occurrences of pixel value `i`.
    @inlinable
    public static func histogram(of image: Image<P, T>) -> [Int] {
        var bins = [Int](repeating: 0, count: Int(UInt8.max)+1)
        
        for px in image.data {
            bins[Int(px)] += 1
        }
        
        return bins
    }
    
    /// Cumulative distribution function of pixel values in image.
    ///
    /// This function assumes pixel value range is [0, 255].
    ///
    /// - Returns: Array of 256 elements.
    @inlinable
    public static func cdf(of image: Image<P, T>) -> [Double] {
        var bins = histogram(of: image)
        
        for i in 1..<bins.count {
            bins[i] += bins[i-1]
        }
        
        let last = Double(bins.last!)
        
        return bins.map { Double($0) / last }
    }
    
    /// Equalize histogram of image.
    ///
    /// This function assumes pixel value range is [0, 255].
    public static func equalize(image: inout Image<P, T>) {
        let cumsum = cdf(of: image)
        
        image.dataConvert { value in
            T(cumsum[Int(value)] * 255)
        }
    }
}
