import XCTest
import Swim

func XCTAssertEqual<T: FloatingPoint>(_ expression1: [T],
                                      _ expression2: [T],
                                      accuracy: T,
                                      file: StaticString = #file,
                                      line: UInt = #line) {
    XCTAssertEqual(expression1.count, expression2.count)
    for (e1, e2) in zip(expression1, expression2) {
        XCTAssertEqual(e1, e2, accuracy: accuracy, "\(expression1) != \(expression2)", file: file, line: line)
        if abs(e1-e2) > accuracy {
            return
        }
    }
}

func XCTAssertEqual<P, T: FloatingPoint>(_ expression1: Image<P, T>,
                                         _ expression2: Image<P, T>,
                                         accuracy: T,
                                         file: StaticString = #file,
                                         line: UInt = #line) {
    XCTAssertEqual(expression1.width, expression2.width, file: file, line: line)
    XCTAssertEqual(expression1.height, expression2.height, file: file, line: line)
    XCTAssertEqual(expression1.data, expression2.data, accuracy: accuracy, file: file, line: line)
}

func XCTAssertEqual<P, T: FloatingPoint>(_ expression1: Pixel<P, T>,
                                         _ expression2: Pixel<P, T>,
                                         accuracy: T,
                                         file: StaticString = #file,
                                         line: UInt = #line) {
    XCTAssertEqual(expression1.data, expression2.data, accuracy: accuracy, file: file, line: line)
}


func XCTAssertEqual<T: FloatingPoint>(_ expression1: T,
                                      _ expression2: T,
                                      rateAccuracy: T,
                                      file: StaticString = #file,
                                      line: UInt = #line) {
    let lower = 1 - rateAccuracy
    let upper = 1 + rateAccuracy
    
    if expression2 >= 0 {
        XCTAssertGreaterThanOrEqual(expression1, expression2 * lower, file: file, line: line)
        XCTAssertLessThanOrEqual(expression1, expression2 * upper, file: file, line: line)
    } else {
        XCTAssertGreaterThanOrEqual(expression1, expression2 * upper, file: file, line: line)
        XCTAssertLessThanOrEqual(expression1, expression2 * lower, file: file, line: line)
    }
}
