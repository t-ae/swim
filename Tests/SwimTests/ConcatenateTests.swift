
import XCTest
import Swim

class ConcatenateTests: XCTestCase {
    
    func testConcatH() {
        let image = Image<RGBA, UInt8>(width: 2, height: 3, data: (0..<6*4).map { UInt8($0) })
        let concat = concatH([image, image, image])
        XCTAssertEqual(concat[cols: 0..<2], image)
        XCTAssertEqual(concat[cols: 2..<4], image)
        XCTAssertEqual(concat[cols: 4..<6], image)
    }
    
    func testConcatV() {
        let image = Image<RGB, UInt8>(width: 2, height: 3, data: (0..<6*3).map { UInt8($0) })
        let concat = concatV([image, image, image])
        XCTAssertEqual(concat[rows: 0..<3], image)
        XCTAssertEqual(concat[rows: 3..<6], image)
        XCTAssertEqual(concat[rows: 6..<9], image)
    }
}
