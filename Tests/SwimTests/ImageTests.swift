import XCTest
import Swim

class ImageTests: XCTestCase {
    
    func testInitialize() {
        do {
            let data = (0..<100).map { UInt8($0) }
            let image = Image(width: 10, height: 10, intensity: data)
            
            XCTAssertEqual(image.data, data)
        }
        do {
            let data = (0..<300).map { Float($0) }
            let image = Image(width: 10, height: 10, rgb: data)
            
            XCTAssertEqual(image.data, data)
        }
        do {
            let data = (0..<400).map { Double($0) }
            let image = Image(width: 10, height: 10, rgba: data)
            
            XCTAssertEqual(image.data, data)
        }
    }
    
    func testEquality() {
        do {
            let image1 = Image(width: 2, height: 2, intensity: [true, false, false, true])
            let image2 = Image(width: 2, height: 2, intensity: [true, false, true, true])
            XCTAssertTrue(image1 == image1)
            XCTAssertFalse(image1 == image2)
        }
        do {
            let data = (0..<100).map { UInt8($0) }
            let image = Image(width: 10, height: 10, intensity: data)
            
            XCTAssertTrue(image == image)
        }
        do {
            let data = (0..<400).map { Double($0) }
            let image = Image(width: 10, height: 10, rgba: data)
            
            XCTAssertTrue(image == image)
        }
    }
    
    func testCoW() {
        do {
            let image1 = Image(width: 2, height: 2, intensity: [true, false, false, true])
            var image2 = image1
            
            image2[0, 0, 0] = false
            
            XCTAssertTrue(image1 != image2)
        }
    }
}
