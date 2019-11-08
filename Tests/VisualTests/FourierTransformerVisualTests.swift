import XCTest
import Swim

class FourierTransformerVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension FourierTransformerVisualTests {
    func testWaves() {
        var images = [Image<Gray, Double>]()
        do { // square wave
            var image = Image<Gray, Double>(width: 256, height: 512, value: 0)
            image.drawRect(126..<130, 254..<258, color: .white)
            
            let fft = FourierTransformer.fft(image: image)
            
            images.append(image)
            images.append(FourierTransformer.spectrum(image: fft, shift: true))
        }
        do { // sine wave
            let sine = Image<Gray, Double>.createWithPixelValues(width: 360, height: 1) { x, y, c in
                (sin(.pi * Double(x) / 180) + 1) / 2
            }
            let image = try! sine.warp(transformation: AffineTransformation(scale: (0.3, 0.3)),
                                       outputSize: (256, 512),
                                       interpolator: BilinearInterpolator(edgeMode: .wrap))
            
            let fft = FourierTransformer.fft(image: image)
            
            images.append(image)
            images.append(FourierTransformer.spectrum(image: fft, shift: true))
        }
        do { // sine wave + rotation
            let sine = Image<Gray, Double>.createWithPixelValues(width: 360, height: 1) { x, y, c in
                (sin(.pi * Double(x) / 180) + 1) / 2
            }
            let image = try! sine.warp(transformation: AffineTransformation(scale: (0.3, 0.3),
                                                                            rotation: .pi/6),
                                       outputSize: (256, 512),
                                       interpolator: BilinearInterpolator(edgeMode: .wrap))
            
            let fft = FourierTransformer.fft(image: image)
            
            images.append(image)
            images.append(FourierTransformer.spectrum(image: fft, shift: true))
        }
        
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testFFT() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, Double>(contentsOf: path).resize(width: 256, height: 256)
        var images: [Image<Gray, Double>] = []
        
        let fft = FourierTransformer.fft(image: lena)
        let shifted = FourierTransformer.shifted(image: fft)
        
        do {
            images.append(FourierTransformer.spectrum(image: shifted))
            
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
            
            images.append(FourierTransformer.spectrum(image: shifted))
            
            // inverse transform
            let fft = FourierTransformer.shifted(image: shifted)
            images.append(FourierTransformer.ifft(image: fft))
        }
        
        do { // high pass filter
            var shifted = shifted
            let highPassFilter = 1 - lowPassFilter
            shifted *= highPassFilter.dataConverted { Complex(real: $0) }
            
            images.append(FourierTransformer.spectrum(image: shifted))
            
            // inverse transform
            let fft = FourierTransformer.shifted(image: shifted)
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
            let result = lena.convoluted(filter)
            images.append(result)
        }
        
        print("Convolution with FFT")
        time {
            // convolution with fft
            let lenafft = FourierTransformer.fft(image: lena)
            
            // adjust size and shift
            let roll = filter.width / 2
            let f2 = filter.withPadding(left: 0, right: lena.width - filter.width,
                                        top: 0, bottom: lena.height - filter.height,
                                        edgeMode: .constant(value: 0))
                .shifted(x: -roll, y: -roll, edgeMode: .wrap)
            
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
