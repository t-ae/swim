import XCTest
import Swim

class PerformanceTests: XCTestCase {
    func testEqual() {
        let image1 = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        var image2 = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        image2[1919, 1079, 3] = 1
        
        measure {
            XCTAssertFalse(image1 == image2)
        }
    }
    
    func testFill() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<10 {
                image.fill(Pixel(r: 1, g: 1, b: 0, a: 1))
            }
        }
    }
    
    func testFlipLR() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.flipLR()
        }
    }
    
    func testWarp() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        
        let affine = AffineTransformation(scale: (2, 1), translation: (640, 0))
        
        measure {
            _ = try? image.warp(transformation: affine)
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
    
    func testConvolution() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.convoluted(Filter.gaussian3x3)
        }
    }
    
    func testRankFilter() {
        let image = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.rankFilter(.maximum, kernelSize: 3)
        }
    }
    
    func testHistogramEqualize() {
        let image = Image<RGB, Int>(width: 1920, height: 1080, value: 1)
        
        measure {
            _ = HistogramEqualizer.equalize(image: image)
        }
    }
    
    func testRot90() {
        let image = Image<RGBA, Int>(width: 1920, height: 1080, value: 1)
        
        measure {
            _ = image.rot90()
        }
    }
    
    func testTranspose() {
        let image = Image<RGBA, Int>(width: 1920, height: 1080, value: 1)
        
        measure {
            _ = image.transpose()
        }
    }
    
    func testCombinationA() {
        let image1 = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let image2 = Image<RGBA, Double>(width: 1920, height: 1080, value: 2)
        
        measure {
            _ = image1.powered(2) + image2.powered(2)
        }
    }
    
    func testCombinationB() {
        let image1 = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let image2 = Image<RGBA, Double>(width: 1920, height: 1080, value: 2)
        
        measure {
            var newImage = Image.zeros(like: image1)
            image1.withUnsafeBufferPointer { p1 in
                image2.withUnsafeBufferPointer { p2 in
                    newImage.withUnsafeMutableBufferPointer { p3 in
                        for i in 0..<p3.count {
                            p3[i] = pow(p1[i], 2) + pow(p2[i], 2)
                        }
                    }
                }
            }
        }
    }
    
    func testFFT() {
        let image = Image<Gray, Double>(width: 1024, height: 1024, value: 1)
        
        measure {
            _ = FourierTransformer.fft(image: image)
        }
    }
}
