import XCTest
import Swim

class TransposeTests: XCTestCase {
    func testTranspose() {
        let image = Image<RGBA, Double>(width: 3, height: 2, data: (0..<3*2*4).map { Double($0) })
        
        let transposed = Image<RGBA, Double>(width: 2,
                                             height: 3,
                                             data: [0, 1, 2, 3, 12, 13, 14, 15,
                                                    4, 5, 6, 7, 16, 17, 18, 19,
                                                    8, 9, 10, 11, 20, 21, 22, 23])
        
        XCTAssertEqual(image.transpose(), transposed)
    }
}
