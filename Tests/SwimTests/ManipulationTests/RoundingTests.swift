import XCTest
import Swim

class RoundingTests: XCTestCase {
    func testRound() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { round($0) })
        
        XCTAssertEqual(image.round(), rounded)
        
        var image2 = image
        image2.applyRound()
        XCTAssertEqual(image2, rounded)
    }
    
    func testCeil() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { ceil($0) })
        
        XCTAssertEqual(image.ceil(), rounded)
        
        var image2 = image
        image2.applyCeil()
        XCTAssertEqual(image2, rounded)
    }
    
    func testFloor() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { floor($0) })
        
        XCTAssertEqual(image.floor(), rounded)
        
        var image2 = image
        image2.applyFloor()
        XCTAssertEqual(image2, rounded)
    }
    
    func testTrunc() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { trunc($0) })
        
        XCTAssertEqual(image.trunc(), rounded)
        
        var image2 = image
        image2.applyTrunc()
        XCTAssertEqual(image2, rounded)
    }
    
    static let allTests = [
        ("testRound", testRound),
        ("testCeil", testCeil),
        ("testFloor", testFloor),
        ("testTrunc", testTrunc)
    ]
}
