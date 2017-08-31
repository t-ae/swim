
import XCTest
import Swim

class ResizeTests: XCTestCase {
    func testDownscale() {
        let image = Image<RGBA, UInt8>(width: 4, height: 4, data: [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                                                                   0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                                                                   2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
                                                                   2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3])
        let resized = image.resized(width: 2, height: 2)
        XCTAssertEqual(resized, Image(width: 2, height: 2, data: [0, 0, 0, 0, 1, 1, 1, 1,
                                                                  2, 2, 2, 2, 3, 3, 3, 3]))
    }
}
