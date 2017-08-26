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
}
