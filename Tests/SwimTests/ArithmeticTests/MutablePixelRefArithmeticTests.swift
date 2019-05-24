import XCTest
import Swim

class MutablePixelRefArithmeticTests: XCTestCase {
    func testAdd() {
        do {
            var image = Image(width: 2, height: 2, rgba: (0..<2*2*4).map { UInt8($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref += 1
                ref += Pixel(r: 0, g: 0, b: 0, a: 1)
            }
            
            answer[0, 0] += 1
            answer[0, 0, .alpha] += 1
            
            XCTAssertEqual(image, answer)
        }
        do {
            var image = Image(width: 2, height: 2, rgba: (0..<2*2*4).map { Double($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref += 1
                ref += Pixel(r: 0, g: 0, b: 0, a: 1)
            }
            
            answer[0, 0] += 1
            answer[0, 0, .alpha] += 1
            
            XCTAssertEqual(image, answer)
        }
    }
    
    func testSub() {
        do {
            var image = Image(width: 2, height: 2, rgba: (10..<10+2*2*4).map { UInt8($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref -= 1
                ref -= Pixel(r: 0, g: 0, b: 0, a: 1)
            }
            
            answer[0, 0] -= 1
            answer[0, 0, .alpha] -= 1
            
            XCTAssertEqual(image, answer)
        }
        do {
            var image = Image(width: 2, height: 2, rgba: (10..<10+2*2*4).map { Double($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref -= 1
                ref -= Pixel(r: 0, g: 0, b: 0, a: 1)
            }
            
            answer[0, 0] -= 1
            answer[0, 0, .alpha] -= 1
            
            XCTAssertEqual(image, answer)
        }
    }
    
    func testMul() {
        do {
            var image = Image(width: 2, height: 2, rgba: (0..<2*2*4).map { UInt8($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref *= 2
                ref *= Pixel(r: 1, g: 1, b: 1, a: 2)
            }
            
            answer[0, 0] *= 2
            answer[0, 0, .alpha] *= 2
            
            XCTAssertEqual(image, answer)
        }
        do {
            var image = Image(width: 2, height: 2, rgba: (0..<2*2*4).map { Double($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref *= 2
                ref *= Pixel(r: 1, g: 1, b: 1, a: 2)
            }
            
            answer[0, 0] *= 2
            answer[0, 0, .alpha] *= 2
            
            XCTAssertEqual(image, answer)
        }
    }
    
    func testDiv() {
        do {
            var image = Image(width: 2, height: 2, rgba: (100..<100+2*2*4).map { UInt8($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref /= 2
                ref /= Pixel(r: 1, g: 1, b: 1, a: 2)
            }
            
            answer[0, 0] /= 2
            answer[0, 0, .alpha] /= 2
            
            XCTAssertEqual(image, answer)
        }
        do {
            var image = Image(width: 2, height: 2, rgba: (100..<100+2*2*4).map { Double($0) })
            var answer = image
            
            image.withMutablePixelRef(x: 0, y: 0) { ref in
                ref /= 2
                ref /= Pixel(r: 1, g: 1, b: 1, a: 2)
            }
            
            answer[0, 0] /= 2
            answer[0, 0, .alpha] /= 2
            
            XCTAssertEqual(image, answer)
        }
    }
    
    static let allTests = [
        ("testAdd", testAdd),
        ("testSub", testSub),
        ("testMul", testMul),
        ("testDiv", testDiv)
    ]
}
