import XCTest
import Swim

class DrawRectTests: XCTestCase {
    func testDrawRect() {
        var image = Image<Gray, UInt8>(width: 100, height: 100, value: 0)
        
        image.drawRect(-50..<50, -50..<50, color: Color(gray: 1))
        
        XCTAssertEqual(image[0..<50, 0..<50], Image.ones(like: image[0..<50, 0..<50]))
        XCTAssertEqual(image[50..<100, 0..<50], Image.zeros(like: image[0..<50, 0..<50]))
        XCTAssertEqual(image[0..<50, 50..<100], Image.zeros(like: image[0..<50, 0..<50]))
        XCTAssertEqual(image[50..<100, 50..<100], Image.zeros(like: image[0..<50, 0..<50]))
    }

    func testDrawRectPelimeter() {
        var image = Image<Gray, UInt8>(width: 100, height: 100, value: 0)
        
        image.drawRectPelimeter(-50..<50, -50..<50, color: Color(gray: 1))
        
        XCTAssertEqual(image[0..<50, 49..<50], Image.ones(like: image[0..<50, 49..<50]))
        XCTAssertEqual(image[49..<50, 0..<50], Image.ones(like: image[49..<50, 0..<50]))
        
        // inside pelimeter
        XCTAssertEqual(image[0..<49, 0..<49], Image.zeros(like: image[0..<49, 0..<49]))
        
        // outside pelimeter
        XCTAssertEqual(image[50..<100, 0..<50], Image.zeros(like: image[0..<50, 0..<50]))
        XCTAssertEqual(image[0..<50, 50..<100], Image.zeros(like: image[0..<50, 0..<50]))
        XCTAssertEqual(image[50..<100, 50..<100], Image.zeros(like: image[0..<50, 0..<50]))
    }
    
    static let allTests = [
        ("testDrawRect", testDrawRect),
        ("testDrawRectPelimeter", testDrawRectPelimeter),
    ]
}
