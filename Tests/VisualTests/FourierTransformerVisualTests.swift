import XCTest
import Swim

class FourierTransformerVisualTests: XCTestCase {

    func testFFT() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Intensity, Double>(contentsOf: path).resize(width: 256, height: 256)
        var images: [Image<Intensity, Double>] = [lena]
        
        let fft = FourierTransformer.fft(image: lena)
        
        // show spectrum
        let shifted = FourierTransformer.shift(image: fft)
        var spectrum = shifted[channel: 0].powered(2) + shifted[channel: 1].powered(2)
        spectrum.channelwiseConvert { log(sqrt($0)) }
        
        let (minSpectrum, maxSpectrum) = spectrum.withUnsafeBufferPointer { ($0.min()!, $0.max()!) }
        images.append((spectrum - minSpectrum) / (maxSpectrum - minSpectrum))
        
        // inverse transform
        let idft = FourierTransformer.ifft(image: fft)
        
        images.append(idft)
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break")
    }
}
