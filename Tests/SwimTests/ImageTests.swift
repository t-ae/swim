import XCTest
import Swim

class ImageTests: XCTestCase {
    
    func testInitialize() {
        do {
            let data = (0..<100).map { UInt8($0) }
            let image = Image<Intensity, UInt8>(width: 10, height: 10, data: data)
            
            XCTAssertEqual(image.data, data)
        }
        do {
            let data = (0..<300).map { Float($0) }
            let image = Image<RGB, Float>(width: 10, height: 10, data: data)
            
            XCTAssertEqual(image.data, data)
        }
        do {
            let data = (0..<400).map { Double($0) }
            let image = Image<RGBA, Double>(width: 10, height: 10, data: data)
            
            XCTAssertEqual(image.data, data)
        }
    }
    
    func testEquality() {
        do {
            let image1 = Image<Intensity, Bool>(width: 2, height: 2, data: [true, false, false, true])
            let image2 = Image<Intensity, Bool>(width: 2, height: 2, data: [true, false, true, true])
            XCTAssertTrue(image1 == image1)
            XCTAssertFalse(image1 == image2)
        }
        do {
            let data = (0..<100).map { UInt8($0) }
            let image = Image<Intensity, UInt8>(width: 10, height: 10, data: data)
            
            XCTAssertTrue(image == image)
        }
        do {
            let data = (0..<400).map { Double($0) }
            let image = Image<RGBA, Double>(width: 10, height: 10, data: data)
            
            XCTAssertTrue(image == image)
        }
    }
}
