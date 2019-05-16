import XCTest
import Swim

class RoundingTests: XCTestCase {
    func testRound() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { round($0) })
        
        XCTAssertEqual(image.rounded(), rounded)
        
        var image2 = image
        image2.round()
        XCTAssertEqual(image2, rounded)
    }
    
    func testCeil() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { ceil($0) })
        
        XCTAssertEqual(image.ceiled(), rounded)
        
        var image2 = image
        image2.ceil()
        XCTAssertEqual(image2, rounded)
    }
    
    func testFloor() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { floor($0) })
        
        XCTAssertEqual(image.floored(), rounded)
        
        var image2 = image
        image2.floor()
        XCTAssertEqual(image2, rounded)
    }
    
    func testTrunc() {
        let data = (-8...7).map { Double($0)+0.1 }
        let image = Image(width: 2, height: 2, rgba: data)
        
        let rounded = Image(width: 2, height: 2, rgba: data.map { trunc($0) })
        
        XCTAssertEqual(image.trunced(), rounded)
        
        var image2 = image
        image2.trunc()
        XCTAssertEqual(image2, rounded)
    }
}
