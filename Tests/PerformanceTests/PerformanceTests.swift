import XCTest
import Swim

class PerformanceTests: XCTestCase {
    func testFillPixelInit() {
        let color = Color<RGBA, Double>(r: 0, g: 1, b: 2, a: 3)
        
        measure {
            _ = Image(width: 3840, height: 2160, color: color)
        }
    }
    
    func testEqual() {
        let image1 = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        var image2 = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        image2[1919, 1079, 3] = 1
        
        measure {
            XCTAssertFalse(image1 == image2)
        }
    }
    
    func testIntegralImage() {
        let image = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                _ = IntegralImageConverter.convert(image: image)
            }
        }
    }
    
    func testIm2col() {
        let image = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.im2col(patchWidth: 3, patchHeight: 3)
        }
    }
    
    func testHistogramEqualize() {
        var image = Image<RGB, Int>(width: 1920, height: 1080, value: 1)
        
        measure {
            Histograms.equalize(image: &image)
        }
    }
    
    func testHistogramEqualizeDouble() {
        var image = Image<RGB, Double>(width: 1920, height: 1080, value: 1)
        
        measure {
            Histograms.equalize(image: &image)
        }
    }
    
    func testCombinationA() {
        let image1 = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let image2 = Image<RGBA, Double>(width: 1920, height: 1080, value: 2)
        
        measure {
            _ = image1.pow(2) + image2.pow(2)
        }
    }
    
    func testCombinationB() {
        let image1 = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let image2 = Image<RGBA, Double>(width: 1920, height: 1080, value: 2)
        
        measure {
            _ = Image<RGBA, Double>.createWithUnsafeMutableBufferPointer(width: 1920, height: 1080) {
                for i in 0..<$0.count {
                    $0[i] = pow(image1[data: i], 2) + pow(image2[data: i], 2)
                }
            }
        }
    }
    
    func testFFT() {
        let image = Image<Gray, Double>(width: 2048, height: 512, value: 1)
        
        measure {
            _ = FourierTransformer.fft(image: image)
        }
    }
    
    func testFFTSquare() {
        let image = Image<Gray, Double>(width: 1024, height: 1024, value: 1)
        
        measure {
            _ = FourierTransformer.fft(image: image)
        }
    }
}
