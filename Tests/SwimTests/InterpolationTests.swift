
import XCTest
@testable import Swim

class InterpolationTests: XCTestCase {
    
    func testNN() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        XCTAssertEqual(image.nearestNeighbor(x: 0, y: 0), Pixel(0))
        XCTAssertEqual(image.nearestNeighbor(x: 2, y: 0), Pixel(2))
        XCTAssertEqual(image.nearestNeighbor(x: 0, y: 2), Pixel(8))
        XCTAssertEqual(image.nearestNeighbor(x: 2, y: 2), Pixel(10))
        XCTAssertEqual(image.nearestNeighbor(x: 3, y: 3), Pixel(15))
    }
    
}
