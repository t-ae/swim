
import XCTest
import Swim

class IntegralImageTests: XCTestCase {
    
    func testToIntegralImage() {
        let image = Image<Intensity, Int>(width: 3, height: 3, data: [Int](repeating: 1, count: 9))
        
        let integral = image.toIntegralImage()
        
        XCTAssertEqual(integral, Image(width: 3, height: 3, data: [1, 2, 3, 2, 4, 6, 3, 6, 9]))
    }
    
}
