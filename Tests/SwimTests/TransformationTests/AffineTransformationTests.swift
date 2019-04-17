import XCTest
import Swim

class AffineTransformationTests: XCTestCase {
    func testAffineTransform() {
        do { // Scale
            let a = AffineTransformation.scale(x: 2, y: 3)
            XCTAssertEqual(a.matrix, [2, 0, 0,
                                      0, 3, 0,
                                      0, 0, 1], accuracy: 0)
        }
        do { // Rotate
            let a = AffineTransformation.rotate(angle: Double.pi/3)
            XCTAssertEqual(a.matrix, [0.5, -sqrt(3)/2, 0,
                                      sqrt(3)/2, 0.5, 0,
                                      0, 0, 1], accuracy: 0.01)
        }
        do { // Translate
            let a = AffineTransformation.translate(x: 2, y: 3)
            XCTAssertEqual(a.matrix, [1, 0, 2,
                                      0, 1, 3,
                                      0, 0, 1], accuracy: 1e-4)
        }
        do { // Inverse
            let a = AffineTransformation.scale(x: 2, y: 3)
                * AffineTransformation.translate(x: 2, y: 3)
                * AffineTransformation.rotate(angle: 1.0)
            let id = a * a.inverse
            XCTAssertEqual(id.matrix, [1, 0, 0,
                                       0, 1, 0,
                                       0, 0, 1], accuracy: 1e-4)
        }
    }
}
