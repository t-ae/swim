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
    
    func testBN() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        XCTAssertEqual(image.interpolateBilinear(x: 0, y: 0), Pixel(0))
        XCTAssertEqual(image.interpolateBilinear(x: 1, y: 0), Pixel(0.5))
        XCTAssertEqual(image.interpolateBilinear(x: 1.5, y: 0), Pixel(1))
        XCTAssertEqual(image.interpolateBilinear(x: 2, y: 0), Pixel(1.5))
        XCTAssertEqual(image.interpolateBilinear(x: 2.5, y: 0), Pixel(2))
        XCTAssertEqual(image.interpolateBilinear(x: 3, y: 0), Pixel(2.5))
        XCTAssertEqual(image.interpolateBilinear(x: 3.9, y: 0), Pixel(3))
        
        XCTAssertEqual(image.interpolateBilinear(x: 0, y: 3.9), Pixel(12))
        XCTAssertEqual(image.interpolateBilinear(x: 3.9, y: 3.9), Pixel(15))
    }
}
