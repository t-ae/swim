import XCTest
import Swim

class PixelIteratorTests: XCTestCase {

    func testIterator() {
        let image = Image<RGBA, UInt8>(width: 3, height: 2, data: (0..<24).map { UInt8($0) })
        
        var iter = image.pixels()
        
        XCTAssertEqual(iter.next(), Pixel(x: 0, y: 0, color: Color(data: [0, 1, 2, 3])))
        XCTAssertEqual(iter.next(), Pixel(x: 1, y: 0, color: Color(data: [4, 5, 6, 7])))
        XCTAssertEqual(iter.next(), Pixel(x: 2, y: 0, color: Color(data: [8, 9, 10, 11])))
        XCTAssertEqual(iter.next(), Pixel(x: 0, y: 1, color: Color(data: [12, 13, 14, 15])))
        XCTAssertEqual(iter.next(), Pixel(x: 1, y: 1, color: Color(data: [16, 17, 18, 19])))
        XCTAssertEqual(iter.next(), Pixel(x: 2, y: 1, color: Color(data: [20, 21, 22, 23])))
        XCTAssertNil(iter.next())
    }
    
    func testIteratorRange() {
        let image = Image<RGBA, UInt8>(width: 4, height: 4, data: (0..<64).map { UInt8($0) })
        
        var iter = image.pixels(in: 1..<3, 1..<3)
        
        XCTAssertEqual(iter.next(), Pixel(x: 1, y: 1, color: Color(data: [20, 21, 22, 23])))
        XCTAssertEqual(iter.next(), Pixel(x: 2, y: 1, color: Color(data: [24, 25, 26, 27])))
        XCTAssertEqual(iter.next(), Pixel(x: 1, y: 2, color: Color(data: [36, 37, 38, 39])))
        XCTAssertEqual(iter.next(), Pixel(x: 2, y: 2, color: Color(data: [40, 41, 42, 43])))
        XCTAssertNil(iter.next())
    }
    
    static let allTests = [
        ("testIterator", testIterator)
    ]
}
