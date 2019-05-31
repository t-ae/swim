import Foundation

public enum ImageStatistics {
    /// Compute peek sound/noise ratio.
    public static func psnr(image1: Image<Gray, Double>, image2: Image<Gray, Double>) -> Double {
        let ssd = Correlation.ssd(image1, image2)
        let mse = ssd / Double(image1.pixelCount)
        
        let psnr = 10 * log10(1 / mse)
        return psnr
    }
    
    /// Compute peek sound/noise ratio.
    public static func psnr(image1: Image<RGB, Double>, image2: Image<RGB, Double>) -> Double {
        return psnr(image1: image1.toGray(), image2: image2.toGray())
    }
}
