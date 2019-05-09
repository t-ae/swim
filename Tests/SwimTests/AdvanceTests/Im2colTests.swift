import XCTest
import Swim

class Im2colTests: XCTestCase {
    
    func testIm2Col() {
        do {
            let image = Image(width: 3, height: 2, intensity: (0..<6).map { Float($0) })
            let (m, n, matrix) = image.im2col(patchWidth: 2, patchHeight: 2)
            XCTAssertEqual(m, 4)
            XCTAssertEqual(n, 2)
            XCTAssertEqual(matrix, [0, 1,
                                    1, 2,
                                    3, 4,
                                    4, 5])
        }
        do {
            let image = Image(width: 3, height: 4, intensity: (0..<12).map { Float($0) })
            let (m, n, matrix) = image.im2col(patchWidth: 3, patchHeight: 2)
            XCTAssertEqual(m, 6)
            XCTAssertEqual(n, 3)
            XCTAssertEqual(matrix, [0, 3, 6,
                                    1, 4, 7,
                                    2, 5, 8,
                                    3, 6, 9,
                                    4, 7, 10,
                                    5, 8, 11])
        }
        do {
            let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
            let (m, n, matrix) = image.im2col(patchWidth: 3, patchHeight: 2)
            XCTAssertEqual(m, 6)
            XCTAssertEqual(n, 6)
            XCTAssertEqual(matrix, [0, 1, 4, 5, 8, 9,
                                    1, 2, 5, 6, 9, 10,
                                    2, 3, 6, 7, 10, 11,
                                    4, 5, 8, 9, 12, 13,
                                    5, 6, 9, 10, 13, 14,
                                    6, 7, 10, 11, 14, 15])
        }
    }
}
