
import XCTest
import Swim

class ArithmeticTests: XCTestCase {
    
    func testNegate() {
        do {
            let before = (0..<16).map { Float.init($0) }
            let after = before.map { -$0 }
            let image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            XCTAssertEqual((-image).data, after)
        }
    }
    
    func testAdd() {
        do {
            let before = (0..<4).map { UInt8($0) }
            let after = before.map { $0 + 1 }
            var image = Image<Intensity, UInt8>(width: 2, height: 2, data: before)
            XCTAssertEqual((image + 1).data, after)
            image += 1
            XCTAssertEqual(image.data, after)
        }
        do {
            let before = (0..<16).map { Float.init($0) }
            let after = before.map { $0 + 1 }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            XCTAssertEqual((image + 1).data, after)
            image += 1
            XCTAssertEqual(image.data, after)
        }
    }
    
    func testSub() {
        do {
            let before = (0..<4).map { UInt8($0+1) }
            let after = before.map { $0 - 1 }
            var image = Image<Intensity, UInt8>(width: 2, height: 2, data: before)
            XCTAssertEqual((image - 1).data, after)
            image -= 1
            XCTAssertEqual(image.data, after)
        }
        do {
            let before = (0..<16).map { Float.init($0) }
            let after = before.map { $0 - 1 }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            XCTAssertEqual((image - 1).data, after)
            image -= 1
            XCTAssertEqual(image.data, after)
        }
    }
    
    func testMul() {
        do {
            let before = (0..<4).map { UInt8($0) }
            let after = before.map { $0 * 2 }
            var image = Image<Intensity, UInt8>(width: 2, height: 2, data: before)
            XCTAssertEqual((image * 2).data, after)
            image *= 2
            XCTAssertEqual(image.data, after)
        }
        do {
            let before = (0..<16).map { Float.init($0) }
            let after = before.map { $0 * 2 }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            XCTAssertEqual((image * 2).data, after)
            image *= 2
            XCTAssertEqual(image.data, after)
        }
    }
    
    func testDiv() {
        do {
            let before = (0..<4).map { UInt8($0) }
            let after = before.map { $0 / 2 }
            var image = Image<Intensity, UInt8>(width: 2, height: 2, data: before)
            XCTAssertEqual((image / 2).data, after)
            image /= 2
            XCTAssertEqual(image.data, after)
        }
        do {
            let before = (0..<16).map { Float.init($0) }
            let after = before.map { $0 / 2 }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            XCTAssertEqual((image / 2).data, after)
            image /= 2
            XCTAssertEqual(image.data, after)
        }
    }
}
