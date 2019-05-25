import XCTest
import Swim

class PixelArithmeticTests: XCTestCase {
    func testNegate() {
        do {
            let before = (0..<4).map { Int($0) }
            let after = before.map { -$0 }
            let pixel = Pixel(rgba: before)
            let answer = Pixel(rgba: after)
            
            XCTAssertEqual(-pixel, answer)
        }
        do {
            let before = (0..<4).map { Double($0) }
            let after = before.map { -$0 }
            let pixel = Pixel(rgba: before)
            let answer = Pixel(rgba: after)
            
            XCTAssertEqual(-pixel, answer)
        }
    }
    
    func testAddInt() {
        var pixel = Pixel<RGBA, Int>(data: [0, 1, 2, 3])
        
        XCTAssertEqual(1 + pixel + pixel + 1, Pixel(data: [2, 4, 6, 8]))
        
        pixel += pixel
        pixel += 1
        
        XCTAssertEqual(pixel, Pixel(data: [1, 3, 5, 7]))
    }
    
    func testAddDouble() {
        var pixel = Pixel<RGBA, Double>(data: [0, 1, 2, 3])
        
        XCTAssertEqual(1 + pixel + pixel + 1, Pixel(data: [2, 4, 6, 8]))
        
        pixel += pixel
        pixel += 1
        
        XCTAssertEqual(pixel, Pixel(data: [1, 3, 5, 7]))
    }
    
    func testSubInt() {
        var pixel = Pixel<RGBA, Int>(data: [0, 1, 2, 3])
        
        XCTAssertEqual(1 - pixel - pixel - 1, Pixel(data: [-0, -2, -4, -6]))
        
        pixel -= pixel
        pixel -= 1
        
        XCTAssertEqual(pixel, Pixel(data: [-1, -1, -1, -1]))
    }
    
    func testSubDouble() {
        var pixel = Pixel<RGBA, Double>(data: [0, 1, 2, 3])
        
        XCTAssertEqual(1 - pixel - pixel - 1, Pixel(data: [-0, -2, -4, -6]))
        
        pixel -= pixel
        pixel -= 1
        
        XCTAssertEqual(pixel, Pixel(data: [-1, -1, -1, -1]))
    }
    
    func testMulInt() {
        var pixel = Pixel<RGBA, Int>(data: [0, 1, 2, 3])
        
        XCTAssertEqual(2 * pixel * pixel * 2, Pixel(data: [0, 4, 16, 36]))
        
        pixel *= pixel
        pixel *= 2
        
        XCTAssertEqual(pixel, Pixel(data: [0, 2, 8, 18]))
    }
    
    func testMulDouble() {
        var pixel = Pixel<RGBA, Double>(data: [0, 1, 2, 3])
        
        XCTAssertEqual(2 * pixel * pixel * 2, Pixel(data: [0, 4, 16, 36]))
        
        pixel *= pixel
        pixel *= 2
        
        XCTAssertEqual(pixel, Pixel(data: [0, 2, 8, 18]))
    }
    
    func testDivInt() {
        var pixel = Pixel<RGBA, Int>(data: [10, 11, 12, 13])
        
        XCTAssertEqual(pixel / 2, Pixel(data: [5, 5, 6, 6]))
        XCTAssertEqual(22 / pixel, Pixel(data: [2, 2, 1, 1]))
        
        pixel *= pixel
        pixel /= Pixel<RGBA, Int>(data: [10, 11, 12, 13])
        pixel /= 2
        
        XCTAssertEqual(pixel, Pixel(data: [5, 5, 6, 6]))
    }
    
    func testDivDouble() {
        let data: [Double] = [10, 11, 12, 13]
        var pixel = Pixel<RGBA, Double>(data: data)
        
        XCTAssertEqual(pixel / 2, Pixel(data: data.map { $0 / 2 }))
        XCTAssertEqual(22 / pixel, Pixel(data: data.map { 22 / $0 }))
        
        pixel /= Pixel<RGBA, Double>(data: data)
        pixel /= 2
        
        XCTAssertEqual(pixel, Pixel(data: [0.5, 0.5, 0.5, 0.5]))
    }
    
    static let allTests = [
        ("testNagate", testNegate),
        ("testAddInt", testAddInt),
        ("testAddDouble", testAddDouble),
        ("testSubInt", testSubInt),
        ("testSubDouble", testSubDouble),
        ("testMulInt", testMulInt),
        ("testMulDouble", testMulDouble),
        ("testDivInt", testDivInt),
        ("testDivDouble", testDivDouble),
    ]
}
