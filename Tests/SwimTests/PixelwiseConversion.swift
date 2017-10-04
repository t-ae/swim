
import XCTest
import Swim

class PixelwiseConversion: XCTestCase {
    
    func testConversion() {
        do {
            let data = (0..<2*3).map { UInt8($0) }
            var image = Image<Intensity, UInt8>(width: 2, height: 3, data: data)
            let after = Image<Intensity, UInt8>(width: 2, height: 3, data: data.map { $0 + 1 })
            
            XCTAssertEqual(image.converted { x, y, px in px + 1 }, after)
            image.convert { x, y, px in  px + 1 }
            XCTAssertEqual(image, after)
        }
    }
}
