import XCTest
import Swim

class IterationPerformanceTests: XCTestCase {
    func testIteration1() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
                    pixel += image[x, y]
                }
            }
        }
    }
    
    func testIteration2() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
                    image.withPixelRef(x: x, y: y) { ref -> Void in
                        pixel += ref
                    }
                }
            }
        }
    }
    
    func testIteration3() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            image.iteratePixels { ref in
                pixel += ref
            }
        }
    }
    
    func testMutableIteration1() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
                    image[x, y] += pixel
                }
            }
        }
    }
    
    func testMutableIteration2() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
                    image.withMutablePixelRef(x: x, y: y) { ref -> Void in
                        ref += pixel
                    }
                }
            }
        }
    }
    
    func testMutableIteration3() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            image.pixelwiseConvert { ref in
                ref += pixel
            }
        }
    }
}
