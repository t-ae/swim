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
    @inlinable
    public static func equalize(image: inout Image<P, T>) {
        let cumsum = cdf(of: image)
        
        image.dataConvert { value in
            T(cumsum[Int(value)] * 255)
        }
    }
}

extension Histograms where T: BinaryFloatingPoint {
    /// Compute histogram of given image.
    ///
    /// This function assumes pixel value range is [0, 1].
    ///
    /// - Returns: Array of `numBins` elements.
    /// `array[i]` represents the number of occurrences of pixel value `i`.
    @inlinable
    public static func histogram(of image: Image<P, T>, numBins: Int) -> (bins: [Int], centers: [T]) {
        
        let edges = (0..<numBins+1).map { T($0) / T(numBins) }
        let centers = (0..<numBins).map { i -> T in
            let sum = edges[i+1] + edges[i]
            return sum / 2
        }
        
        var bins = [Int](repeating: 0, count: numBins)
        
        for value in image.data {
            let binIndex = (edges.firstIndex { $0 > value } ?? (edges.count-1)) - 1
            bins[binIndex] += 1
        }
        
        return (bins, centers)
    }
    
    /// Cumulative distribution function of pixel values in image.
    ///
    /// This function assumes pixel value range is [0, 1].
    ///
    /// - Returns: Array of `numBins` elements.
    @inlinable
    public static func cdf(of image: Image<P, T>, numBins: Int) -> ([T], centers: [T]) {
        var (bins, centers) = histogram(of: image, numBins: numBins)
        
        for i in 1..<bins.count {
            bins[i] += bins[i-1]
        }
        
        let last = T(bins.last!)
        
        return (bins.map { T($0) / last }, centers)
    }
    
    /// Equalize histogram of image.
    ///
    /// This function assumes pixel value range is [0, 1].
    @inlinable
    public static func equalize(image: inout Image<P, T>, numBins: Int = 256) {
        let (cumsum, center) = cdf(of: image, numBins: numBins)
        
        image.dataConvert { value in
            let i = min(Int(value * T(numBins)), numBins-1)
            let binIndex = min(Int(cumsum[i] * T(numBins)), numBins-1)
            return center[binIndex]
        }
    }
}
