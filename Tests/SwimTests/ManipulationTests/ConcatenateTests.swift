import XCTest
import Swim

class ConcatenateTests: XCTestCase {
    
    func testConcatH() {
        do {
            let image1 = Image(width: 2, height: 3, rgba: (0..<6*4).map { UInt8($0) })
            let image2 = Image(width: 3, height: 3, rgba: (0..<9*4).map { UInt8($0) })
            let concat = Image.concatH([image1, image2, image1, image2])
            
            XCTAssertEqual(concat[cols: 0..<2], image1)
            XCTAssertEqual(concat[cols: 2..<5], image2)
            XCTAssertEqual(concat[cols: 5..<7], image1)
            XCTAssertEqual(concat[cols: 7..<10], image2)
        }
        do {
            let image1 = Image(width: 2, height: 3, rgba: (0..<6*4).map { Double($0) })
            let image2 = Image(width: 3, height: 3, rgba: (0..<9*4).map { Double($0) })
            let concat = Image.concatH([image1, image2, image1, image2])
            
            XCTAssertEqual(concat[cols: 0..<2], image1)
            XCTAssertEqual(concat[cols: 2..<5], image2)
            XCTAssertEqual(concat[cols: 5..<7], image1)
            XCTAssertEqual(concat[cols: 7..<10], image2)
        }
    }
    
    func testConcatV() {
        do {
            let image1 = Image(width: 2, height: 3, rgb: (0..<6*3).map { Int($0) })
            let image2 = Image(width: 2, height: 2, rgb: (0..<4*3).map { Int($0) })
            let concat = Image.concatV([image1, image2, image1, image2])
            
            XCTAssertEqual(concat[rows: 0..<3], image1)
            XCTAssertEqual(concat[rows: 3..<5], image2)
            XCTAssertEqual(concat[rows: 5..<8], image1)
            XCTAssertEqual(concat[rows: 8..<10], image2)
        }
        do {
            let image1 = Image(width: 2, height: 3, rgb: (0..<6*3).map { Double($0) })
            let image2 = Image(width: 2, height: 2, rgb: (0..<4*3).map { Double($0) })
            let concat = Image.concatV([image1, image2, image1, image2])
            
            XCTAssertEqual(concat[rows: 0..<3], image1)
            XCTAssertEqual(concat[rows: 3..<5], image2)
            XCTAssertEqual(concat[rows: 5..<8], image1)
            XCTAssertEqual(concat[rows: 8..<10], image2)
        }
    }
}
