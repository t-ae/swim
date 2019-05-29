import XCTest
import Swim

class ConversionPerformanceTests: XCTestCase {
    func testPixelwiseConvert() {
        var image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            for _ in 0..<10 {
                image.pixelwiseConvert { src in
                    src += 1
                }
            }
        }
    }
    
    func testPixelwiseConverted() {
        let image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            for _ in 0..<10 {
                _ = image.pixelwiseConverted { src, dst in
                    dst[.red] = src[.red]
                    dst[.green] = src[.green]
                    dst[.blue] = src[.blue]
                    dst[.alpha] = src[.alpha]
                    } as Image<RGBA, UInt8>
            }
        }
    }
    
    func testChannelwiseConvert() {
        var image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            for _ in 0..<100 {
                image.dataConvert { src in
                    src &+ 1
                }
            }
        }
    }
    
    func testChannelwiseConverted() {
        let image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            for _ in 0..<10 {
                _ = image.dataConverted { $0 + 1 }
            }
        }
    }
    
    func testToGrayInt() {
        let image = Image<RGB, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image.toGray()
        }
    }
    
    func testToGrayDouble() {
        let image = Image<RGB, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image.toGray()
        }
    }
    
    func testCompundRGBA() {
        let r = Image<Gray, Double>(width: 3840, height: 2160, value: 0.3)
        let g = Image<Gray, Double>(width: 3840, height: 2160, value: 0.3)
        let b = Image<Gray, Double>(width: 3840, height: 2160, value: 0.3)
        let a = Image<Gray, Double>(width: 3840, height: 2160, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = Image(r: r, g: g, b: b, a: a)
            }
        }
    }
    
    func testCompundRGBA2() {
        let rgb = Image<RGB, Double>(width: 3840, height: 2160, value: 0.3)
        let a = Image<Gray, Double>(width: 3840, height: 2160, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = Image(rgb: rgb, a: a)
            }
        }
    }
    
    func testGrayToRGB() {
        let g = Image<Gray, Double>(width: 3840, height: 2160, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = g.toRGB()
            }
        }
    }
    
    func testRGBToGray() {
        let g = Image<RGB, Double>(width: 3840, height: 2160, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = g.toGray()
            }
        }
    }
    
    func testRGBToRGBA() {
        let rgb = Image<RGB, Double>(width: 3840, height: 2160, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = rgb.toRGBA(with: 1)
            }
        }
    }
    
    func testRGBAToARGB() {
        let rgba = Image<RGBA, Double>(width: 3840, height: 2160, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = rgba.toARGB()
            }
        }
    }
    
    func testRGBAToRGB() {
        let rgba = Image<RGBA, Double>(width: 3840, height: 2160, value: 0.3)
        
        measure {
            for _ in 0..<10 {
                _ = rgba.toRGB()
            }
        }
    }
}
