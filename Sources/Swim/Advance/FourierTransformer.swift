import Foundation

public enum FourierTransformer {
    /// Fast fourier transformation.
    ///
    /// - Returns: Single channel complex image.
    /// - Precondition: width/height of image are power of 2.
    @inlinable
    public static func fft(image: Image<Gray, Double>) -> Image<Gray, Complex<Double>> {
        precondition(image.width.isPOT, "image width must be power of 2.")
        precondition(image.height.isPOT, "image height must be power of 2.")
        
        var image = image.dataConverted { Complex(real: $0) }
        
        fftx(image: &image, inverse: false)
        image = image.transposed()
        fftx(image: &image, inverse: false)
        image = image.transposed()
        
        return image
    }
    
    /// Inverse fast fourier transformation.
    ///
    /// - Parameter image: Single channel complex image.
    ///
    /// - Precondition: width/height of image are power of 2.
    @inlinable
    public static func ifft(image: Image<Gray, Complex<Double>>) -> Image<Gray, Double> {
        precondition(image.width.isPOT, "image width must be power of 2.")
        precondition(image.width.isPOT, "image height must be power of 2.")
        var image = image
        fftx(image: &image, inverse: true)
        image = image.transposed()
        fftx(image: &image, inverse: true)
        image = image.transposed()
        
        return image.dataConverted { $0.real }
    }
    
    /// Shift output of fft by (width/2, height/2).
    @inlinable
    public static func shift(image: Image<Gray, Complex<Double>>) -> Image<Gray, Complex<Double>> {
        precondition(image.width % 2 == 0, "Image width must be even number.")
        precondition(image.height % 2 == 0, "Image height must be even number.")
        
        return image.shifted(x: image.width/2, y: image.height/2, edgeMode: .wrap)
    }
    
    /// Get spectrum from FFT result.
    ///
    /// The result is log-scale magnitude of each `Complex`es normalized in [0, 1] range.
    ///
    /// - Parameters:
    ///   - shift: If `true`, call `FourierTransformer.shift` beforehand. Default: `false`.
    @inlinable
    public static func spectrum(image: Image<Gray, Complex<Double>>,
                                shift: Bool = false) -> Image<Gray, Double> {
        var image = image
        if shift {
            image = FourierTransformer.shift(image: image)
        }
        let logmag = image.dataConverted { log1p($0.magnitude) }
        
        let extrema = logmag.extrema()
        return logmag.dataConverted { value in
            (value - extrema.min) / (extrema.max - extrema.min)
        }
    }
    
    /// Fast fourier transformation horizontally.
    @inlinable
    static func fftx(image: inout Image<Gray, Complex<Double>>, inverse: Bool) {
        assert(image.width.isPOT)
        
        let n = image.width
        let theta = 2 * Double.pi / Double(n) * (inverse ? 1 : -1)
        
        let wLUT: [Complex<Double>] = (0..<n).map {
            Complex(real: cos(theta * Double($0)),
                    imag: sin(theta * Double($0)))
        }
        
        // http://www.kurims.kyoto-u.ac.jp/~ooura/fftman/ftmn1_2.html
        func inplaceFFT(data: UnsafeMutableBufferPointer<Complex<Double>>) {
            // bitreverse
            var i = 0
            for j in 1..<n-1 {
                var k = n >> 1
                while true {
                    i ^= k
                    guard k > i else { break }
                    k >>= 1
                }
                if j < i {
                    swap(&data[j], &data[i])
                }
            }
            
            // butterfly
            var mh = 1
            while true {
                let m = mh << 1
                guard m <= n else { break }
                
                var irev = 0
                for i in stride(from: 0, to: n, by: m) {
                    let w = wLUT[irev]
                    
                    var k = n >> 2
                    while true {
                        irev ^= k
                        guard k > irev else { break }
                        k >>= 1
                    }
                    
                    for j in i..<mh+i {
                        let k = j+mh
                        
                        let x = data[j] - data[k]
                        data[j] += data[k]
                        data[k] = w * x
                    }
                }
                
                mh = m
            }
        }
        
        // FFT each row
        let countInRow = image.width * Gray.channels
        for start in stride(from: 0, to: image.data.count, by: countInRow) {
            image.data[start..<start+countInRow].withUnsafeMutableBufferPointer {
                inplaceFFT(data: $0)
            }
        }
        
        if inverse {
            let n = Double(n)
            image.dataConvert {
                Complex(real: $0.real / n, imag: $0.imag / n)
            }
        }
    }
}
