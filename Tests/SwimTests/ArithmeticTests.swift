
import XCTest
import Swim

class ArithmeticTests: XCTestCase {
    
    func testNegate() {
        do {
            let before = (0..<16).map { Int.init($0) }
            let after = before.map { -$0 }
            let image = Image<RGBA, Int>(width: 2, height: 2, data: before)
            XCTAssertEqual((-image).data, after)
        }
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
            XCTAssertEqual((1 + image).data, after)
            image += 1
            XCTAssertEqual(image.data, after)
        }
        do {
            let before = (0..<16).map { Float.init($0) }
            let after = before.map { $0 + 1 }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            XCTAssertEqual((image + 1).data, after)
            XCTAssertEqual((1 + image).data, after)
            image += 1
            XCTAssertEqual(image.data, after)
        }
    }
    
    func testSub() {
        do {
            let before = (0..<4).map { UInt8($0+1) }
            var image = Image<Intensity, UInt8>(width: 2, height: 2, data: before)
            let after1 = before.map { $0 - 1 }
            XCTAssertEqual((image - 1).data, after1)
            let after2 = before.map { 255 - $0 }
            XCTAssertEqual((255 - image).data, after2)
            image -= 1
            XCTAssertEqual(image.data, after1)
        }
        do {
            let before = (0..<16).map { Float.init($0) }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            let after1 = before.map { $0 - 1 }
            XCTAssertEqual((image - 1).data, after1)
            let after2 = before.map { 255 - $0 }
            XCTAssertEqual((255 - image).data, after2)
            image -= 1
            XCTAssertEqual(image.data, after1)
        }
    }
    
    func testMul() {
        do {
            let before = (0..<4).map { UInt8($0) }
            let after = before.map { $0 * 2 }
            var image = Image<Intensity, UInt8>(width: 2, height: 2, data: before)
            XCTAssertEqual((image * 2).data, after)
            XCTAssertEqual((2 * image).data, after)
            image *= 2
            XCTAssertEqual(image.data, after)
        }
        do {
            let before = (0..<16).map { Float.init($0) }
            let after = before.map { $0 * 2 }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            XCTAssertEqual((image * 2).data, after)
            XCTAssertEqual((2 * image).data, after)
            image *= 2
            XCTAssertEqual(image.data, after)
        }
    }
    
    func testDiv() {
        do {
            let before = (0..<4).map { UInt8($0+1) }
            var image = Image<Intensity, UInt8>(width: 2, height: 2, data: before)
            let after1 = before.map { $0 / 2 }
            XCTAssertEqual((image / 2).data, after1)
            let after2 = before.map { 10 / $0 }
            XCTAssertEqual((10 / image).data, after2)
            image /= 2
            XCTAssertEqual(image.data, after1)
        }
        do {
            let before = (0..<16).map { Float.init($0+1) }
            var image = Image<RGBA, Float>(width: 2, height: 2, data: before)
            let after1 = before.map { $0 / 2 }
            XCTAssertEqual((image / 2).data, after1)
            let after2 = before.map { 10 / $0 }
            XCTAssertEqual((10 / image).data, after2, accuracy: 1e-3)
            image /= 2
            XCTAssertEqual(image.data, after1)
        }
    }
}
