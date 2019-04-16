import XCTest
import Swim

class ConcatenateTests: XCTestCase {
    
    func testConcatH() {
        do {
            let image = Image(width: 2, height: 3, rgba: (0..<6*4).map { UInt8($0) })
            let concat = Image<RGBA, UInt8>.concatH([image, image, image])
            XCTAssertEqual(concat[cols: 0..<2], image)
            XCTAssertEqual(concat[cols: 2..<4], image)
            XCTAssertEqual(concat[cols: 4..<6], image)
        }
        do {
            let image = Image(width: 2, height: 3, rgb: (0..<6*3).map { Double($0) })
            let concat = Image<RGB, Double>.concatH([image, image, image])
            XCTAssertEqual(concat[cols: 0..<2], image)
            XCTAssertEqual(concat[cols: 2..<4], image)
            XCTAssertEqual(concat[cols: 4..<6], image)
        }
    }
    
    func testConcatV() {
        do {
            let image = Image(width: 2, height: 3, rgb: (0..<6*3).map { Int($0) })
            let concat = Image<RGB, Int>.concatV([image, image, image])
            XCTAssertEqual(concat[rows: 0..<3], image)
            XCTAssertEqual(concat[rows: 3..<6], image)
            XCTAssertEqual(concat[rows: 6..<9], image)
        }
        do {
            let image = Image(width: 2, height: 3, intensity: (0..<6).map { Double($0) })
            let concat = Image<Intensity, Double>.concatV([image, image, image])
            XCTAssertEqual(concat[rows: 0..<3], image)
            XCTAssertEqual(concat[rows: 3..<6], image)
            XCTAssertEqual(concat[rows: 6..<9], image)
        }
    }
}
