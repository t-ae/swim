import XCTest
import Swim

class ArithmeticPerformanceTests: XCTestCase {
    func testMulScalar() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image *= 1.1
        }
    }
    
    func testMulPixel() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0.9, g: 1.1, b: 0.9, a: 1.1)
        
        measure {
            image *= pixel
        }
    }
    
    func testMulImage() {
        var image1 = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let image2 = Image<RGBA, Double>(width: 3840, height: 2160, value: 1.1)
        
        measure {
            image1 *= image2
        }
    }
}
