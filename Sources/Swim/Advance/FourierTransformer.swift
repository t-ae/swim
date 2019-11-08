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
        transpose(image: &image)
        fftx(image: &image, inverse: false)
        transpose(image: &image)
        
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
        transpose(image: &image)
        fftx(image: &image, inverse: true)
        transpose(image: &image)
        
        return image.dataConverted { $0.real }
    }
    
    /// Shift output of FFT by (width/2, height/2).
    @inlinable
    public static func shifted(image: Image<Gray, Complex<Double>>) -> Image<Gray, Complex<Double>> {
        var image = image
        shift(image: &image)
        return image
    }
    
    /// Shift output of FFT by (width/2, height/2).
    @inlinable
    public static func shift(image: inout Image<Gray, Complex<Double>>) {
        precondition(image.width % 2 == 0, "Image width must be even number.")
        precondition(image.height % 2 == 0, "Image height must be even number.")
        
        let w = image.width
        let w2 = image.width/2
        let h2 = image.height/2
        
        image.withUnsafeMutableBufferPointer { bp in
            _ = [Complex<Double>](unsafeUninitializedCapacity: w) { buf, count in
                let buf1 = buf.baseAddress!
                let buf2 = buf1 + w2
                var lt = bp.baseAddress!
                var rt = lt + w2
                var lb = lt + w * h2
                var rb = lb + w2
                
                for _ in 0..<h2 {
                    buf1.moveInitialize(from: rb, count: w2)
                    buf2.moveInitialize(from: lb, count: w2)
                    rb.moveInitialize(from: lt, count: w2)
                    lb.moveInitialize(from: rt, count: w2)
                    lt.moveInitialize(from: buf1, count: w)
                    
                    lt += w
                    rt += w
                    lb += w
                    rb += w
                }
                
                count = 0
            }
        }
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
            FourierTransformer.shift(image: &image)
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
        
        // wLUT: irev -> w (0 <= irev < n/2)
        let wLUT: [Complex<Double>] = (0..<n/2).map {
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
                    data.swapAt(i, j)
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
    
    /// Transpose given image.
    ///
    /// If `image` is square, it does in-place transposition.
    /// Otherwise, call `image.transposed` which is out-of-place.
    @inlinable
    static func transpose<T>(image: inout Image<Gray, T>) {
        guard image.width == image.height else {
            image = image.transposed()
            return
        }
        
        for y in 0..<image.height {
            for x in y+1..<image.width {
                let i = y*image.width + x
                let j = x*image.width + y
                image.data.swapAt(i, j)
            }
        }
    }
}
