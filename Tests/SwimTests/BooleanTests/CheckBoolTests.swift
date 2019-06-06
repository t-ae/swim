import XCTest
import Swim

class CheckBoolTests: XCTestCase {

    func testHasTrue() {
        let image = Image<Gray, Bool>(width: 2, height: 2, data: [true, false,
                                                                  true, false])
        
        XCTAssertTrue(image.hasTrue())
        XCTAssertTrue(image[0..<1, 0..<2].hasTrue())
        XCTAssertFalse(image[1..<2, 0..<2].hasTrue())
    }

    func testHasFalse() {
        let image = Image<Gray, Bool>(width: 2, height: 2, data: [true, false,
                                                                  true, false])
        
        XCTAssertTrue(image.hasFalse())
        XCTAssertFalse(image[0..<1, 0..<2].hasFalse())
        XCTAssertTrue(image[1..<2, 0..<2].hasFalse())
    }
    
    func testAllTrue() {
        let image = Image<Gray, Bool>(width: 2, height: 2, data: [true, false,
                                                                  true, false])
        
        XCTAssertFalse(image.allTrue())
        XCTAssertTrue(image[0..<1, 0..<2].allTrue())
        XCTAssertFalse(image[1..<2, 0..<2].allTrue())
    }
    
    func testAllFalse() {
        let image = Image<Gray, Bool>(width: 2, height: 2, data: [true, false,
                                                                  true, false])
        
        XCTAssertFalse(image.allFalse())
        XCTAssertFalse(image[0..<1, 0..<2].allFalse())
        XCTAssertTrue(image[1..<2, 0..<2].allFalse())
    }
    
    static let allTests = [
        ("testHasTrue", testHasTrue),
        ("testHasFalse", testHasFalse),
        ("testAllTrue", testAllTrue),
        ("testAllFalse", testAllFalse),
    ]
}
