import XCTest
import Swim

class HomogeneousTransformationMatrixTests: XCTestCase {
    func testHomogeneousTransform() {
        do {
            let a = ProjectiveTransformation(1, -1, 1,
                                                    1, 1, 0,
                                                    0, 3, 1)
            let inv = try! a.inverted()
            let id = a * inv
            
            XCTAssertEqual(id.e00, 1, accuracy: 1e-4)
            XCTAssertEqual(id.e01, 0, accuracy: 1e-4)
            XCTAssertEqual(id.e02, 0, accuracy: 1e-4)
            XCTAssertEqual(id.e10, 0, accuracy: 1e-4)
            XCTAssertEqual(id.e11, 1, accuracy: 1e-4)
            XCTAssertEqual(id.e12, 0, accuracy: 1e-4)
            XCTAssertEqual(id.e20, 0, accuracy: 1e-4)
            XCTAssertEqual(id.e21, 0, accuracy: 1e-4)
            XCTAssertEqual(id.e22, 1, accuracy: 1e-4)
        }
    }
}
