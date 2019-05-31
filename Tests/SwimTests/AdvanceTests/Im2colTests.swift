import XCTest
import Swim

class Im2colTests: XCTestCase {
    
    func testIm2Col() {
        do {
            let image = Image(width: 3, height: 2, gray: (0..<6).map { Float($0) })
            let matrix = image.im2col(patchWidth: 2, patchHeight: 2)
            XCTAssertEqual(matrix, Matrix(rows: 4, cols: 2, data: [0, 1,
                                                                   1, 2,
                                                                   3, 4,
                                                                   4, 5]))
        }
        do {
            let image = Image(width: 3, height: 4, gray: (0..<12).map { Float($0) })
            let matrix = image.im2col(patchWidth: 3, patchHeight: 2)
            XCTAssertEqual(matrix, Matrix(rows: 6, cols: 3, data: [0, 3, 6,
                                                                   1, 4, 7,
                                                                   2, 5, 8,
                                                                   3, 6, 9,
                                                                   4, 7, 10,
                                                                   5, 8, 11]))
        }
        do {
            let image = Image(width: 4, height: 4, gray: (0..<16).map { Float($0) })
            let matrix = image.im2col(patchWidth: 3, patchHeight: 2)
            XCTAssertEqual(matrix, Matrix(rows: 6, cols: 6, data: [0, 1, 4, 5, 8, 9,
                                                                   1, 2, 5, 6, 9, 10,
                                                                   2, 3, 6, 7, 10, 11,
                                                                   4, 5, 8, 9, 12, 13,
                                                                   5, 6, 9, 10, 13, 14,
                                                                   6, 7, 10, 11, 14, 15]))
        }
    }
    
    static let allTests = [
        ("testIm2Col", testIm2Col)
    ]
}
