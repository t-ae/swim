import XCTest
import Swim

class FourierTransformerPerformanceTests: XCTestCase {
    func testFFT() {
        let image = Image<Gray, Double>(width: 2048, height: 512, value: 1)
        
        measure {
            _ = FourierTransformer.fft(image: image)
        }
    }
    
    func testIFFT() {
        let image = Image<Gray, Complex>(width: 2048, height: 512, value: Complex(real: 0.3, imag: 0.2))
        
        measure {
            _ = FourierTransformer.ifft(image: image)
        }
    }
    
    func testFFTSquare() {
        let image = Image<Gray, Double>(width: 1024, height: 1024, value: 1)
        
        measure {
            _ = FourierTransformer.fft(image: image)
        }
    }
    
    func testFFTShifted() {
        let image = Image<Gray, Complex>(width: 1024, height: 1024, value: Complex(real: 1, imag: 2))
        
        measure {
            _ = FourierTransformer.shifted(image: image)
        }
    }
    
    func testFFTShift() {
        var image = Image<Gray, Complex>(width: 1024, height: 1024, value: Complex(real: 1, imag: 2))
        
        measure {
            FourierTransformer.shift(image: &image)
        }
    }
}
