import Foundation

public enum HistogramEqualizer {
    public static func equalize(image: Image<Intensity, UInt8>) -> Image<Intensity, UInt8> {
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
            UInt8(Int(UInt8.max) * cumsum[Int(px)] / scale)
        }
        
        return newImage
    }
}
