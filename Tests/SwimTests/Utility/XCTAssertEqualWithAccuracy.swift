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
    XCTAssertEqual(expression1.withUnsafeBufferPointer { Array($0) },
                   expression2.withUnsafeBufferPointer { Array($0) },
                   accuracy: accuracy,
                   file: file,
                   line: line)
}
