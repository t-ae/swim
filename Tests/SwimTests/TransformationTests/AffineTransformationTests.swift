import XCTest
import Swim

func XCTAssertEqual<T>(_ expression1: AffineTransformation<T>,
                       _ expression2: AffineTransformation<T>,
                       rateAccuracy: T,
                       file: StaticString = #file,
                       line: UInt = #line) {
    
    XCTAssertEqual(expression1.a, expression2.a, rateAccuracy: rateAccuracy, file: file, line: line)
    XCTAssertEqual(expression1.b, expression2.b, rateAccuracy: rateAccuracy, file: file, line: line)
    XCTAssertEqual(expression1.c, expression2.c, rateAccuracy: rateAccuracy, file: file, line: line)
    XCTAssertEqual(expression1.d, expression2.d, rateAccuracy: rateAccuracy, file: file, line: line)
    XCTAssertEqual(expression1.tx, expression2.tx, rateAccuracy: rateAccuracy, file: file, line: line)
    XCTAssertEqual(expression1.ty, expression2.ty, rateAccuracy: rateAccuracy, file: file, line: line)
}

class AffineTransformationTests: XCTestCase {
    func testAffineTransform() {
        do { // Scale
            let a = AffineTransformation.scale(x: 2, y: 3)
            XCTAssertEqual(a, AffineTransformation(a: 2, b: 0, c: 0, d: 3, tx: 0, ty: 0), rateAccuracy: 0)
        }
        do { // Rotate
            let a = AffineTransformation.rotate(angle: Double.pi/3)
            XCTAssertEqual(a, AffineTransformation(a: 0.5, b: -sqrt(3)/2, c: sqrt(3)/2, d: 0.5, tx: 0, ty: 0 ), rateAccuracy: 0.01)
        }
        do { // Translate
            let a = AffineTransformation.translate(x: 2, y: 3)
            XCTAssertEqual(a, AffineTransformation(a: 1, b: 0, c: 0, d: 1, tx: 2, ty: 3), rateAccuracy: 0)
        }
    }
}
