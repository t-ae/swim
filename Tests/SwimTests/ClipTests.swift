
import XCTest
import Swim

class ClipTests: XCTestCase {
    
    func testClip() {
        do {
            let data = (0..<10).map { UInt8($0) }
            let image = Image<Intensity, UInt8>(width: 2, height: 5, data: data)
            
            let clipped = image.clipped(low: 1, high: 6)
            XCTAssertEqual(clipped, Image(width: 2, height: 5, data: [1, 1, 2, 3 ,4, 5, 6, 6, 6, 6]))
        }
        do {
            let data = (0..<10).map { Double($0) }
            let image = Image<Intensity, Double>(width: 2, height: 5, data: data)
            
            let clipped = image.clipped(low: 1, high: 6)
            XCTAssertEqual(clipped, Image(width: 2, height: 5, data: [1, 1, 2, 3 ,4, 5, 6, 6, 6, 6]))
        }
    }
    
}
