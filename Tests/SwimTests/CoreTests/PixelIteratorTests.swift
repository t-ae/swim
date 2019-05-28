import XCTest
import Swim

class PixelIteratorTests: XCTestCase {

    func testIterator() {
        let image = Image<RGBA, UInt8>(width: 3, height: 2, data: (0..<24).map { UInt8($0) })
        
        var iter = image.pixels()
        
        XCTAssertEqual(iter.next(), Color(data: [0, 1, 2, 3]))
        XCTAssertEqual(iter.next(), Color(data: [4, 5, 6, 7]))
        XCTAssertEqual(iter.next(), Color(data: [8, 9, 10, 11]))
        XCTAssertEqual(iter.next(), Color(data: [12, 13, 14, 15]))
        XCTAssertEqual(iter.next(), Color(data: [16, 17, 18, 19]))
        XCTAssertEqual(iter.next(), Color(data: [20, 21, 22, 23]))
        XCTAssertNil(iter.next())
    }
    
    static let allTests = [
        ("testIterator", testIterator)
    ]
}
