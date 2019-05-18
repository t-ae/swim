import Foundation

public enum FourierTransformer {
    /// Fast fourier transform.
    @inlinable
    public static func fft(image: Image<Intensity, Double>) -> Image<IntensityAlpha, Double> {
        precondition(Int(exactly: log2(Double(image.width))) != nil, "image width must be power of 2.")
        precondition(Int(exactly: log2(Double(image.height))) != nil, "image height must be power of 2.")
        var image = image.toIntensityAlpha(with: 0)
        
        fftx(image: &image, inverse: false)
        image = image.transpose()
        fftx(image: &image, inverse: false)
        image = image.transpose()
        
        return image
    }
    
    /// Inverse fast fourier transform.
    @inlinable
    public static func ifft(image: Image<IntensityAlpha, Double>) -> Image<Intensity, Double> {
        precondition(Int(exactly: log2(Double(image.width))) != nil, "image width must be power of 2.")
        precondition(Int(exactly: log2(Double(image.height))) != nil, "image height must be power of 2.")
        var image = image
        fftx(image: &image, inverse: true)
        image = image.transpose()
        fftx(image: &image, inverse: true)
        image = image.transpose()
        
        return image[channel: .intensity]
    }
    
    @inlinable
    public static func shift(image: Image<IntensityAlpha, Double>) -> Image<IntensityAlpha, Double> {
        precondition(image.width % 2 == 0)
        precondition(image.height % 2 == 0)
        
        let w1 = 0..<image.width/2
        let w2 = image.width/2..<image.width
        let h1 = 0..<image.height/2
        let h2 = image.height/2..<image.height
        
        return Image.concat([[image[w2, h2], image[w1, h2]],
                             [image[w2, h1], image[w1, h1]]])
    }
    
    /// Fast fourier transform horizontally.
    @inlinable
    static func fftx(image: inout Image<IntensityAlpha, Double>, inverse: Bool) {
        assert(Int(exactly: log2(Double(image.width))) != nil)
        
        let countInRow = image.width * IntensityAlpha.channels
        for y in 0..<image.height {
            let start = image.dataIndex(x: 0, y: y)
            image.data[start..<start+countInRow].withUnsafeMutableBufferPointer {
                inplaceFFT(data: $0, inverse: inverse)
            }
        }
    }
    
    /// 1D FFT.
    /// http://www.kurims.kyoto-u.ac.jp/~ooura/fftman/ftmn1_2.html
    @inlinable
    static func inplaceFFT(data: UnsafeMutableBufferPointer<Double>, inverse: Bool) {
        assert(data.count % 2 == 0)
        let n = data.count / 2
        let theta = 2 * Double.pi / Double(n) * (inverse ? 1 : -1)
        
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
                swap(&data[2*j+0], &data[2*i+0])
                swap(&data[2*j+1], &data[2*i+1])
            }
        }
        
        // fft
        var mh = 1
        while true {
            let m = mh << 1
            guard m <= n else { break }
            
            var irev = 0
            for i in stride(from: 0, to: n, by: m) {
                let wr = cos(theta * Double(irev))
                let wi = sin(theta * Double(irev))
                
                var k = n >> 2
                while true {
                    irev ^= k
                    guard k > irev else { break }
                    k >>= 1
                }
                
                for j in i..<mh+i {
                    let k = j+mh
                    let xr = data[2*j+0] - data[2*k+0]
                    let xi = data[2*j+1] - data[2*k+1]
                    data[2*j+0] += data[2*k+0]
                    data[2*j+1] += data[2*k+1]
                    data[2*k+0] = wr * xr - wi * xi
                    data[2*k+1] = wr * xi + wi * xr
                }
            }
            
            mh = m
        }
        
        if inverse {
            for i in 0..<data.count {
                data[i] /= Double(n)
            }
        }
    }
}
