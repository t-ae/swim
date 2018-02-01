
import XCTest
@testable import Swim

class MatmulTests: XCTestCase {

    func testMatmul() {
        do {
            let a: [Float] = [1, 2, 3, 4, 5, 6]
            XCTAssertEqual(_matmul(lhs: a, rhs: a, m: 3, n: 3, p: 2), [9, 12, 15, 19, 26, 33, 29, 40, 51])
            XCTAssertEqual(matmul(lhs: a, rhs: a, m: 3, n: 3, p: 2), [9, 12, 15, 19, 26, 33, 29, 40, 51])
            
            XCTAssertEqual(_matmul(lhs: a, rhs: a, m: 2, n: 2, p: 3), [22, 28, 49, 64])
            XCTAssertEqual(matmul(lhs: a, rhs: a, m: 2, n: 2, p: 3), [22, 28, 49, 64])
        }
        do {
            let a: [Double] = [1, 2, 3, 4, 5, 6]
            XCTAssertEqual(_matmul(lhs: a, rhs: a, m: 3, n: 3, p: 2), [9, 12, 15, 19, 26, 33, 29, 40, 51])
            XCTAssertEqual(matmul(lhs: a, rhs: a, m: 3, n: 3, p: 2), [9, 12, 15, 19, 26, 33, 29, 40, 51])
            
            XCTAssertEqual(_matmul(lhs: a, rhs: a, m: 2, n: 2, p: 3), [22, 28, 49, 64])
            XCTAssertEqual(matmul(lhs: a, rhs: a, m: 2, n: 2, p: 3), [22, 28, 49, 64])
        }
    }

}
