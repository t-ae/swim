import XCTest
import Swim

class DrawTests: XCTestCase {
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
    
    func testDrawImage() {
        var image = Image<RGB, Int>(width: 100, height: 100, value: 0)
        let draw = Image<RGB, Int>(width: 10, height: 10, data: (0..<300).map { Int($0) })
        
        image.drawImage(origin: (-5, -5), image: draw)
        XCTAssertEqual(image[0..<5, 0..<5], draw[5..<10, 5..<10])
        
        image.drawImage(origin: (98, 95), image: draw)
        XCTAssertEqual(image[98..<100, 95..<100], draw[0..<2, 0..<5])
        
        var mask = Image<Gray, Bool>.full(value: false, like: draw)
        mask.drawLine(p1: (1, 1), p2: (1, 3), color: Color(gray: true))
        mask.drawLine(p1: (1, 1), p2: (5, 1), color: Color(gray: true))
        image.drawImage(origin: (10, 10), image: draw, mask: mask)
        XCTAssertEqual(image[11..<16, 11..<12], draw[1..<6, 1..<2])
        XCTAssertEqual(image[11..<12, 11..<14], draw[1..<2, 1..<4])
    }
    
    func testDrawText() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 30) else {
            return
        }
        
        let original = Image<RGB, Int>(width: 100, height: 100, value: 0)
        var image = original
        image.drawText(position: (0, 0), text: "test", font: font, color: .red, anchor: .leftTop)
        
        // Check at least drawing something
        XCTAssertNotEqual(image, original)
    }
    
    static let allTests = [
        ("testDrawRect", testDrawRect),
        ("testDrawRectPelimeter", testDrawRectPelimeter),
        ("testDrawImage", testDrawImage),
        ("testDrawText", testDrawText),
    ]
}
