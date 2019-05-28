import XCTest
import Swim

class ColorArithmeticTests: XCTestCase {
    func testNegate() {
        do {
            let image = Image(width: 2, height: 1, rgba: [0, 1, 2, 3, 0, 1, 2, 3])
            let color = image[1, 0]
            
            let answer = Color(rgba: [-0, -1, -2, -3])
            
            XCTAssertEqual(-color, answer)
        }
        do {
            let image = Image(width: 2, height: 1, rgba: [0.0, 1, 2, 3, 0, 1, 2, 3])
            let color = image[1, 0]
            
            let answer = Color(rgba: [-0.0, -1, -2, -3])
            
            XCTAssertEqual(-color, answer)
        }
    }
    
    func testAddInt() {
        let image = Image(width: 2, height: 1, rgba: [0, 1, 2, 3, 0, 1, 2, 3])
        var color = image[1, 0]
        
        var t = 1 + color
        t = t + color
        t = t + 1
        XCTAssertEqual(t, Color(data: [2, 4, 6, 8]))
        
        color += color
        color += 1
        
        XCTAssertEqual(color, Color(data: [1, 3, 5, 7]))
    }
    
    func testAddDouble() {
        let image = Image(width: 2, height: 1, rgba: [0.0, 1, 2, 3, 0, 1, 2, 3])
        var color = image[1, 0]
        
        var t = 1 + color
        t = t + color
        t = t + 1
        XCTAssertEqual(t, Color(data: [2, 4, 6, 8]))
        
        color += color
        color += 1
        
        XCTAssertEqual(color, Color(data: [1, 3, 5, 7]))
    }
    
    func testSubInt() {
        let image = Image(width: 2, height: 1, rgba: [0, 1, 2, 3, 0, 1, 2, 3])
        var color = image[1, 0]
        
        var t = 1 - color
        t = t - color
        t = t - 1
        XCTAssertEqual(t, Color(data: [-0, -2, -4, -6]))
        
        color -= color
        color -= 1
        
        XCTAssertEqual(color, Color(data: [-1, -1, -1, -1]))
    }
    
    func testSubDouble() {
        let image = Image(width: 2, height: 1, rgba: [0.0, 1, 2, 3, 0, 1, 2, 3])
        var color = image[1, 0]
        
        var t = 1 - color
        t = t - color
        t = t - 1
        XCTAssertEqual(t, Color(data: [-0, -2, -4, -6]))
        
        color -= color
        color -= 1
        
        XCTAssertEqual(color, Color(data: [-1, -1, -1, -1]))
    }
    
    func testMulInt() {
        let image = Image(width: 2, height: 1, rgba: [0, 1, 2, 3, 0, 1, 2, 3])
        var color = image[1, 0]
        
        var t = 2 * color
        t = t * color
        t = t * 2
        XCTAssertEqual(t, Color(data: [0, 4, 16, 36]))
        
        color *= color
        color *= 2
        
        XCTAssertEqual(color, Color(data: [0, 2, 8, 18]))
    }
    
    func testMulDouble() {
        let image = Image(width: 2, height: 1, rgba: [0.0, 1, 2, 3, 0, 1, 2, 3])
        var color = image[1, 0]
        
        var t = 2 * color
        t = t * color
        t = t * 2
        XCTAssertEqual(t, Color(data: [0, 4, 16, 36]))
        
        color *= color
        color *= 2
        
        XCTAssertEqual(color, Color(data: [0, 2, 8, 18]))
    }
    
    func testDivInt() {
        let image = Image(width: 2, height: 1, rgba: [0, 1, 2, 3, 10, 11, 12, 13])
        var color = image[1, 0]
        
        XCTAssertEqual(color / 2, Color(data: [5, 5, 6, 6]))
        XCTAssertEqual(22 / color, Color(data: [2, 2, 1, 1]))
        
        color *= color
        color /= image[1, 0]
        color /= 2
        
        XCTAssertEqual(color, Color(data: [5, 5, 6, 6]))
    }
    
    func testDivDouble() {
        let image = Image(width: 2, height: 1, rgba: [0.0, 1, 2, 3, 10, 11, 12, 13])
        var color = image[1, 0]
        
        XCTAssertEqual(color / 2, Color(data: [10, 11, 12, 13].map { $0/2 }))
        XCTAssertEqual(22 / color, Color(data: [10, 11, 12, 13].map { 22/$0 }))
        
        color /= image[1, 0]
        color /= 2
        
        XCTAssertEqual(color, Color(data: [0.5, 0.5, 0.5, 0.5]))
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
