import XCTest
import Swim

class FourierTransformerVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension FourierTransformerVisualTests {
    func getSpectrum(shifted: Image<GrayAlpha, Double>) -> Image<Gray, Double> {
        var spectrum = shifted[channel: 0].powered(2) + shifted[channel: 1].powered(2)
        spectrum.dataConvert { log1p(sqrt($0)) }
        
        let (minSpectrum, maxSpectrum) = spectrum.withUnsafeBufferPointer { ($0.min()!, $0.max()!) }
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
            shifted[channel: .gray] *= lowPassFilter
            shifted[channel: .alpha] *= lowPassFilter
            
            images.append(getSpectrum(shifted: shifted))
            
            // inverse transform
            let fft = FourierTransformer.shift(image: shifted)
            images.append(FourierTransformer.ifft(image: fft))
        }
        
        do { // high pass filter
            var shifted = shifted
            let highPassFilter = 1 - lowPassFilter
            shifted[channel: .gray] *= highPassFilter
            shifted[channel: .alpha] *= highPassFilter
            
            images.append(getSpectrum(shifted: shifted))
            
            // inverse transform
            let fft = FourierTransformer.shift(image: shifted)
            images.append(FourierTransformer.ifft(image: fft))
        }
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
