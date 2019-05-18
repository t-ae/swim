import XCTest
import Swim
class BitOperationsTests: XCTestCase {
    func testNegate() {
        var image = Image<RGB, Bool>(width: 1, height: 1, data: [true, false, false])
        
        XCTAssertEqual(~image, Image(width: 1, height: 1, data: [false, true, true]))
        
        image.negate()
        
        XCTAssertEqual(image, Image(width: 1, height: 1, data: [false, true, true]))
    }

    func testAnd() {
        var image1 = Image<RGBA, Bool>(width: 1, height: 1, data: [true, true, false, false])
        let image2 = Image<RGBA, Bool>(width: 1, height: 1, data: [true, false, true, false])
        
        XCTAssertEqual(image1&image2, Image(width: 1, height: 1, data: [true, false, false, false]))
        
        image1 &= image2
        
        XCTAssertEqual(image1, Image(width: 1, height: 1, data: [true, false, false, false]))
    }
    
    func testOr() {
        var image1 = Image<RGBA, Bool>(width: 1, height: 1, data: [true, true, false, false])
        let image2 = Image<RGBA, Bool>(width: 1, height: 1, data: [true, false, true, false])
        
        XCTAssertEqual(image1|image2, Image(width: 1, height: 1, data: [true, true, true, false]))
        
        image1 |= image2
        
        XCTAssertEqual(image1, Image(width: 1, height: 1, data: [true, true, true, false]))
    }
    
    func testXor() {
        var image1 = Image<RGBA, Bool>(width: 1, height: 1, data: [true, true, false, false])
        let image2 = Image<RGBA, Bool>(width: 1, height: 1, data: [true, false, true, false])
        
        XCTAssertEqual(image1^image2, Image(width: 1, height: 1, data: [false, true, true, false]))
        
        image1 ^= image2
        
        XCTAssertEqual(image1, Image(width: 1, height: 1, data: [false, true, true, false]))
    }
}
