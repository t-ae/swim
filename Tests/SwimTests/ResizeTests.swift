
import XCTest
import Swim

class ResizeTests: XCTestCase {
    func testDownscale() {
        let image = Image(width: 4,
                          height: 4,
                          rgba: [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                                 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                                 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
                                 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3].map { UInt8($0) })
        let resized = image.resized(width: 2, height: 2)
        XCTAssertEqual(resized, Image(width: 2, height: 2, data: [0, 0, 0, 0, 1, 1, 1, 1,
                                                                  2, 2, 2, 2, 3, 3, 3, 3]))
    }
}
