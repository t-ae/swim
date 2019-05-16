import XCTest
import Swim

class ConversionPerformanceTests: XCTestCase {
    func testPixelwiseConvert() {
        var image = Image<RGBA, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<10 {
                image.pixelwiseConvert { src in
                    src += 1
                }
            }
        }
    }
    
    func testPixelwiseConverted() {
        let image = Image<RGBA, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.pixelwiseConverted { src in
                Pixel(from: src)
            }
        }
    }
    
    func testPixelwiseConvertedWithReservedPixel() {
        let image = Image<RGBA, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            var pixel = Pixel<RGBA, UInt8>.zero
            _ = image.pixelwiseConverted { src -> Pixel<RGBA, UInt8> in
                pixel[.red] = src[.red]
                pixel[.green] = src[.green]
                pixel[.blue] = src[.blue]
                pixel[.alpha] = src[.alpha]
                return pixel
            }
        }
    }
    
    func testChannelwiseConvert() {
        var image = Image<RGBA, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                image.channelwiseConvert { src in
                    src &+ 1
                }
            }
        }
    }
    
    func testChannelwiseConverted() {
        let image = Image<RGBA, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                _ = image.channelwiseConverted { $0 + 1 }
            }
        }
    }
    
    func testBrightnessInt() {
        let image = Image<RGB, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                _ = image.toBrightness()
            }
        }
    }
    
    func testBrightnessDouble() {
        let image = Image<RGB, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                _ = image.toBrightness()
            }
        }
    }
    func testLuminanceInt() {
        let image = Image<RGB, UInt8>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                _ = image.toLuminance()
            }
        }
    }
    
    func testLuminanceDouble() {
        let image = Image<RGB, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                _ = image.toLuminance()
            }
        }
    }
    
    func testCompundRGBA() {
        let r = Image<Intensity, Double>(width: 1920, height: 1080, value: 0.3)
        let g = Image<Intensity, Double>(width: 1920, height: 1080, value: 0.3)
        let b = Image<Intensity, Double>(width: 1920, height: 1080, value: 0.3)
        let a = Image<Intensity, Double>(width: 1920, height: 1080, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = Image(r: r, g: g, b: b, a: a)
            }
        }
    }
    
    func testCompundRGBA2() {
        let rgb = Image<RGB, Double>(width: 1920, height: 1080, value: 0.3)
        let a = Image<Intensity, Double>(width: 1920, height: 1080, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = Image(rgb: rgb, a: a)
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
