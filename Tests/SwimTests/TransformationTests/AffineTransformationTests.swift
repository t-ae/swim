import XCTest
import Swim

class AffineTransformationTests: XCTestCase {
    func testAffineTransform() {
        do { // Scale
            let a = AffineTransformation.scale(x: 2, y: 3)
            XCTAssertEqual(a,
                           AffineTransformation(a: 2, b: 0, tx: 0,
                                                c: 0, d: 3, ty: 0),
                           accuracy: 0)
        }
        do { // Rotate
            let a = AffineTransformation.rotation(angle: Double.pi/3)
            XCTAssertEqual(a,
                           AffineTransformation(a: 0.5, b: -sqrt(3)/2, tx: 0,
                                                c: sqrt(3)/2, d: 0.5, ty: 0),
                           accuracy: 0.01)
        }
        do { // Translate
            let a = AffineTransformation.translation(x: 2, y: 3)
            XCTAssertEqual(a,
                           AffineTransformation(a: 1, b: 0, tx: 2,
                                                c: 0, d: 1, ty: 3),
                           accuracy: 1e-4)
        }
        do { // Inverse
            let a = AffineTransformation.scale(x: 2, y: 3)
                * AffineTransformation.translation(x: 2, y: 3)
                * AffineTransformation.rotation(angle: 1.0)
            let id = try! a * a.inverted()
            XCTAssertEqual(id,
                           AffineTransformation.identity,
                           accuracy: 1e-4)
        }
    }
}

private func XCTAssertEqual<T: BinaryFloatingPoint>(_ expression1: AffineTransformation<T>,
                                                    _ expression2: AffineTransformation<T>,
                                                    accuracy: T,
                                                    file: StaticString = #file,
                                                    line: UInt = #line) {
    XCTAssertEqual(expression1.a, expression2.a, accuracy: accuracy, file: file, line: line)
}
