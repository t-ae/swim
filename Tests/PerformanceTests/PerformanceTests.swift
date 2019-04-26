import XCTest
import Swim

class PerformanceTests: XCTestCase {
    func testConvert() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        var image = Image(width: 1920, height: 1080, rgba: data)
        
        measure {
            image.pixelwiseConvert { px in
                px += 1
            }
        }
    }
    
    func testConverted() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        let image = Image(width: 1920, height: 1080, rgba: data)
        
        measure {
            _ = image.pixelwiseConverted { src in
                src + 1
            }
        }
    }
    
    func testChannelwiseConverted() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        let image = Image(width: 1920, height: 1080, rgba: data)
        
        measure {
            _ = image.channelwiseConverted { $0 + 1 }
        }
    }
    
    func testBrightness() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        let image = Image(width: 1920, height: 1080, rgb: data)
        
        measure {
            _ = image.toBrightness()
        }
    }
    
    func testSubimageSubscript() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        var image = Image(width: 1920, height: 1080, rgb: data)
        
        measure {
            for _ in 0..<100_000 {
                image[0..<16, 0..<16] += 0.01
            }
        }
    }
    
    func testChannelSubscript() {
        let data = [Double](repeating: 0, count: 1920*1080*3)
        var image = Image(width: 1920, height: 1080, rgb: data)
        
        measure {
            image[channel: .red] += 0.01
        }
    }
    
    func testFlipLR() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        let image = Image(width: 1920, height: 1080, rgb: data)
        
        measure {
            _ = image.flipLR()
        }
    }
    
    func testWarp() {
        let data = [Float](repeating: 0, count: 640*480*3)
        let image = Image(width: 640, height: 480, rgb: data)
        
        let affine = AffineTransformation<Float>(scale: (-1, 1), translation: (640, 0))
        
        measure {
            _ = try? image.warp(transformation: affine)
        }
    }
    
    func testIntegralImage() {
        let data = [Float](repeating: 0, count: 1920*1080)
        let image = Image(width: 1920, height: 1080, intensity: data)
        
        measure {
            _ = IntegralImageConverter.convert(image: image)
        }
    }
    
    func testConvolution() {
        let data = [Float](repeating: 0, count: 1920*1080)
        let image = Image(width: 1920, height: 1080, intensity: data)
        
        measure {
            _ = image.convoluted(Filter.gaussian3x3)
        }
    }
    
    func testFilter() {
        let data = [Float](repeating: 0, count: 640*480)
        let image = Image(width: 640, height: 480, intensity: data)
        
        measure {
            _ = image.maximumFilter(kernelSize: 3)
        }
    }
}
