
import XCTest
import Swim

class FloatingPointTests: XCTestCase {
    
    func testRound() {
        do {
            let image = Image(width: 2, height: 2, rgba: (1...16).map(Float.init))
            
            XCTAssertEqual((image + 0.1).rounded(), image)
            
            var image2 = image + 0.1
            image2.round()
            XCTAssertEqual(image2, image)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (1...16).map(Double.init))
            
            XCTAssertEqual((image + 0.1).rounded(), image)
            
            var image2 = image + 0.1
            image2.round()
            XCTAssertEqual(image2, image)
        }
    }
    
    func testCeil() {
        do {
            let image = Image(width: 2, height: 2, rgba: (1...16).map(Float.init))
            
            XCTAssertEqual((image - 0.1).ceiled(), image)
            
            var image2 = image - 0.1
            image2.ceil()
            XCTAssertEqual(image2, image)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (1...16).map(Double.init))
            
            XCTAssertEqual((image - 0.1).ceiled(), image)
            
            var image2 = image - 0.1
            image2.ceil()
            XCTAssertEqual(image2, image)
        }
    }
    
    func testFloor() {
        do {
            let image = Image(width: 2, height: 2, rgba: (1...16).map(Float.init))
            
            XCTAssertEqual((image + 0.1).floored(), image)
            
            var image2 = image + 0.1
            image2.floor()
            XCTAssertEqual(image2, image)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (1...16).map(Double.init))
            
            XCTAssertEqual((image + 0.1).floored(), image)
            
            var image2 = image + 0.1
            image2.floor()
            XCTAssertEqual(image2, image)
        }
    }
}
