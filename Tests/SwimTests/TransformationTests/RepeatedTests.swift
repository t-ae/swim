import XCTest
import Swim

class RepeatedTests: XCTestCase {

    func testRepeated() {
        let image = Image<RGBA, Double>(width: 3, height: 4, data: (0..<48).map { Double($0) })
        
        let repeated = image.repeated(horizontally: 2, vertically: 3)
        
        XCTAssertEqual(repeated[0..<3, 0..<4], image)
        XCTAssertEqual(repeated[3..<6, 0..<4], image)
        
        XCTAssertEqual(repeated[0..<3, 4..<8], image)
        XCTAssertEqual(repeated[3..<6, 4..<8], image)
        
        XCTAssertEqual(repeated[0..<3, 8..<12], image)
        XCTAssertEqual(repeated[3..<6, 8..<12], image)
    }
}
