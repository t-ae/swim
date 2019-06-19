import XCTest
import Swim

class FourierTransformerVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension FourierTransformerVisualTests {
    func getSpectrum(shifted: Image<Gray, Complex<Double>>) -> Image<Gray, Double> {
        var spectrum = shifted.dataConverted { $0.magnitude }
        spectrum.dataConvert { log1p(sqrt($0)) }
        
        let (minSpectrum, maxSpectrum) = spectrum.extrema()
        return (spectrum - minSpectrum) / (maxSpectrum - minSpectrum)
    }
    
    func testWaves() {
        var images = [Image<Gray, Double>]()
        do { // square wave
            var image = Image<Gray, Double>(width: 512, height: 512, value: 0)
            image.drawRect(254..<258, 254..<258, color: .white)
            
            let fft = FourierTransformer.fft(image: image)
            let shifted = FourierTransformer.shift(image: fft)
            
            images.append(image)
            images.append(getSpectrum(shifted: shifted))
        }
        do { // sine wave
            let sine = Image<Gray, Double>.createWithPixelValues(width: 360, height: 1) { x, y, c in
                (sin(.pi * Double(x) / 180) + 1) / 2
            }
            let image = try! sine.warp(transformation: AffineTransformation(scale: (0.3, 0.3)),
                                       outputSize: (512, 512),
                                       interpolator: BilinearInterpolator(edgeMode: .wrap))
            
            let fft = FourierTransformer.fft(image: image)
            let shifted = FourierTransformer.shift(image: fft)
            
            images.append(image)
            images.append(getSpectrum(shifted: shifted))
        }
        do { // sine wave + rotation
            let sine = Image<Gray, Double>.createWithPixelValues(width: 360, height: 1) { x, y, c in
                (sin(.pi * Double(x) / 180) + 1) / 2
            }
            let image = try! sine.warp(transformation: AffineTransformation(scale: (0.3, 0.3),
                                                                            rotation: .pi/6),
                                       outputSize: (512, 512),
                                       interpolator: BilinearInterpolator(edgeMode: .wrap))
            
            let fft = FourierTransformer.fft(image: image)
            let shifted = FourierTransformer.shift(image: fft)
            
            images.append(image)
            images.append(getSpectrum(shifted: shifted))
        }
        
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testFFT() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, Double>(contentsOf: path).resize(width: 256, height: 256)
        var images: [Image<Gray, Double>] = []
        
        let fft = FourierTransformer.fft(image: lena)
        let shifted = FourierTransformer.shift(image: fft)
        
        do {
            images.append(getSpectrum(shifted: shifted))
            
            // inverse transform
            images.append(FourierTransformer.ifft(image: fft))
        }
        
        var lowPassFilter = Image<Gray, Double>.zeros(like: shifted)
        lowPassFilter.drawCircle(center: (x: (lowPassFilter.width-1)/2,
                                          y: (lowPassFilter.height-1)/2),
                                 radius: 20,
                                 color: Color(gray: 1))
        do { // low pass filter
            var shifted = shifted
            shifted *= lowPassFilter.dataConverted { Complex(real: $0) }
            
            images.append(getSpectrum(shifted: shifted))
            
            // inverse transform
            let fft = FourierTransformer.shift(image: shifted)
            images.append(FourierTransformer.ifft(image: fft))
        }
        
        do { // high pass filter
            var shifted = shifted
            let highPassFilter = 1 - lowPassFilter
            shifted *= highPassFilter.dataConverted { Complex(real: $0) }
            
            images.append(getSpectrum(shifted: shifted))
            
            // inverse transform
            let fft = FourierTransformer.shift(image: shifted)
            images.append(FourierTransformer.ifft(image: fft))
        }
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testConvolutionWithFFT() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, Double>(contentsOf: path).resize(width: 256, height: 256)
        var images: [Image<Gray, Double>] = [lena]
        
        let filter = Filter.gaussian(size: 13, sigma: 3, scaleTo1: true)
        
        print("Image.convoluted")
        time {
            let lap = lena.convoluted(filter)
            images.append(lap)
        }
        
        print("Convolution with FFT")
        time {
            // convolution with fft
            let lenafft = FourierTransformer.fft(image: lena)
            
            // adjust size
            var f2 = filter.withPadding(left: 0, right: lena.width - filter.width,
                                        top: 0, bottom: lena.height - filter.height,
                                        edgeMode: .constant(value: 0))
            // roll
            let roll = filter.width / 2
            f2 = f2.withPadding(left: 0, right: roll, top: 0, bottom: roll, edgeMode: .wrap)
            f2 = f2[roll..<f2.width, roll..<f2.height]
            let f2fft = FourierTransformer.fft(image: f2)
            
            let fft = lenafft * f2fft
            
            let image = FourierTransformer.ifft(image: fft)
            images.append(image)
        }
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
