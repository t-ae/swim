import XCTest
import Swim

class FillTests: XCTestCase {
    func testFillValue() {
        var image = Image<RGBA, Double>(width: 640, height: 480, value: 0)
        
        image.fill(0.5)
        
        XCTAssertEqual(image, Image(width: 640, height: 480, value: 0.5))
    }
    
    func testFillPixel() {
        var image = Image<RGBA, Double>(width: 640, height: 480, value: 0)
        let pixel = Pixel(r: 0.3, g: 0.2, b: 0.1, a: 1.0)
        
        image.fill(pixel)
        
        XCTAssertEqual(image, Image(width: 640, height: 480, pixel: pixel))
    }
}
