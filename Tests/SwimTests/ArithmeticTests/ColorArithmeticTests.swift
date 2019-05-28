import XCTest
import Swim

class ColorArithmeticTests: XCTestCase {
    func testNegate() {
        do {
            let before = (0..<4).map { Int($0) }
            let after = before.map { -$0 }
            let color = Color(rgba: before)
            let answer = Color(rgba: after)
            
            XCTAssertEqual(-color, answer)
        }
        do {
            let before = (0..<4).map { Double($0) }
            let after = before.map { -$0 }
            let color = Color(rgba: before)
            let answer = Color(rgba: after)
            
            XCTAssertEqual(-color, answer)
        }
    }
    
    func testAddInt() {
        var color = Color<RGBA, Int>(data: [0, 1, 2, 3])
        
        var t = 1 + color
        t = t + color
        t = t + 1
        XCTAssertEqual(t, Color(data: [2, 4, 6, 8]))
        
        color += color
        color += 1
        
        XCTAssertEqual(color, Color(data: [1, 3, 5, 7]))
    }
    
    func testAddDouble() {
        var color = Color<RGBA, Double>(data: [0, 1, 2, 3])
        
        var t = 1 + color
        t = t + color
        t = t + 1
        XCTAssertEqual(t, Color(data: [2, 4, 6, 8]))
        
        color += color
        color += 1
        
        XCTAssertEqual(color, Color(data: [1, 3, 5, 7]))
    }
    
    func testSubInt() {
        var color = Color<RGBA, Int>(data: [0, 1, 2, 3])
        
        var t = 1 - color
        t = t - color
        t = t - 1
        XCTAssertEqual(t, Color(data: [-0, -2, -4, -6]))
        
        color -= color
        color -= 1
        
        XCTAssertEqual(color, Color(data: [-1, -1, -1, -1]))
    }
    
    func testSubDouble() {
        var color = Color<RGBA, Double>(data: [0, 1, 2, 3])
        
        var t = 1 - color
        t = t - color
        t = t - 1
        XCTAssertEqual(t, Color(data: [-0, -2, -4, -6]))
        
        color -= color
        color -= 1
        
        XCTAssertEqual(color, Color(data: [-1, -1, -1, -1]))
    }
    
    func testMulInt() {
        var color = Color<RGBA, Int>(data: [0, 1, 2, 3])
        
        var t = 2 * color
        t = t * color
        t = t * 2
        XCTAssertEqual(t, Color(data: [0, 4, 16, 36]))
        
        color *= color
        color *= 2
        
        XCTAssertEqual(color, Color(data: [0, 2, 8, 18]))
    }
    
    func testMulDouble() {
        var color = Color<RGBA, Double>(data: [0, 1, 2, 3])
        
        var t = 2 * color
        t = t * color
        t = t * 2
        XCTAssertEqual(t, Color(data: [0, 4, 16, 36]))
        
        color *= color
        color *= 2
        
        XCTAssertEqual(color, Color(data: [0, 2, 8, 18]))
    }
    
    func testDivInt() {
        var color = Color<RGBA, Int>(data: [10, 11, 12, 13])
        
        XCTAssertEqual(color / 2, Color(data: [5, 5, 6, 6]))
        XCTAssertEqual(22 / color, Color(data: [2, 2, 1, 1]))
        
        color *= color
        color /= Color<RGBA, Int>(data: [10, 11, 12, 13])
        color /= 2
        
        XCTAssertEqual(color, Color(data: [5, 5, 6, 6]))
    }
    
    func testDivDouble() {
        let data: [Double] = [10, 11, 12, 13]
        var color = Color<RGBA, Double>(data: data)
        
        XCTAssertEqual(color / 2, Color(data: data.map { $0 / 2 }))
        XCTAssertEqual(22 / color, Color(data: data.map { 22 / $0 }))
        
        color /= Color<RGBA, Double>(data: data)
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
