import XCTest
import Swim

class AffineTransformationTests: XCTestCase {
    func testAffineTransform() {
        do { // Scale
            let a = AffineTransformation.scale(x: 2, y: 3)
            XCTAssertEqual(a.matrix.elements,
                           [2, 0, 0,
                            0, 3, 0,
                            0, 0, 1],
                           accuracy: 0)
        }
        do { // Rotate
            let a = AffineTransformation.rotate(angle: Double.pi/3)
            XCTAssertEqual(a.matrix.elements,
                           [0.5, -sqrt(3)/2, 0,
                            sqrt(3)/2, 0.5, 0,
                            0, 0, 1],
                           accuracy: 0.01)
        }
        do { // Translate
            let a = AffineTransformation.translate(x: 2, y: 3)
            XCTAssertEqual(a.matrix.elements,
                           [1, 0, 2,
                            0, 1, 3,
                            0, 0, 1],
                           accuracy: 1e-4)
        }
        do { // Inverse
            let a = AffineTransformation.scale(x: 2, y: 3)
                * AffineTransformation.translate(x: 2, y: 3)
                * AffineTransformation.rotate(angle: 1.0)
            let id = try! a * a.inverted()
            XCTAssertEqual(id.matrix.elements,
                           [1, 0, 0,
                            0, 1, 0,
                            0, 0, 1],
                           accuracy: 1e-4)
        }
    }
}
