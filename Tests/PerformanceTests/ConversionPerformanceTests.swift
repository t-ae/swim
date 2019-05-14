import XCTest
import Swim

class ConversionPerformanceTests: XCTestCase {
    func testPixelwiseConvert() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        var image = Image(width: 1920, height: 1080, rgba: data)
        
        measure {
            image.pixelwiseConvert { src in
                src += 1
            }
        }
    }
    
    func testPixelwiseConverted() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        let image = Image(width: 1920, height: 1080, rgba: data)
        
        measure {
            _ = image.pixelwiseConverted { src in
                src + 1
            }
        }
    }
    
    func testChannelwiseConvert() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        var image = Image(width: 1920, height: 1080, rgba: data)
        
        measure {
            image.channelwiseConvert { src in
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
        let data = [Double](repeating: 0, count: 1920*1080*3)
        let image = Image(width: 1920, height: 1080, rgb: data)
        
        measure {
            for _ in 0..<100 {
                _ = image.toBrightness()
            }
        }
    }
    
    func testLuminance() {
        let data = [Double](repeating: 0, count: 1920*1080*3)
        let image = Image(width: 1920, height: 1080, rgb: data)
        
        measure {
            for _ in 0..<100 {
                _ = image.toLuminance()
            }
        }
    }
    
    func testCompundRGBA() {
        let g = Image<Intensity, Double>(width: 1920, height: 1080, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = Image(r: g, g: g, b: g, a: g)
            }
        }
    }
    
    func testIntensityToRGB() {
        let g = Image<Intensity, Double>(width: 1920, height: 1080, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = g.toRGB()
            }
        }
    }
    
    func testRGBAToARGB() {
        let rgba = Image<RGBA, Double>(width: 1920, height: 1080, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = rgba.toARGB()
            }
        }
    }
}
