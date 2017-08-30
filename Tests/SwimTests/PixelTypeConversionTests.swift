
import XCTest
import Swim

class PixelTypeConversionTests: XCTestCase {
    
    func testRGBtoGBA() {
        let image = Image<RGB, Float>(width: 1920, height: 1080, data: [Float](repeating: 0, count: 1920*1080*3))
        
        measure {
            _ = Image<RGBA, Float>(image: image)
        }
    }
    
}
