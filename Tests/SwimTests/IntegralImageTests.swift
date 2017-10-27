
import XCTest
import Swim

class IntegralImageTests: XCTestCase {
    
    func testToIntegralImage() {
        do {
            let image = Image<Intensity, Int>(width: 3, height: 3, data: [Int](repeating: 1, count: 9))
            
            let integral = image.toIntegralImage()
            
            XCTAssertEqual(integral, Image(width: 3, height: 3, data: [1, 2, 3, 2, 4, 6, 3, 6, 9]))
        }
        do {
            let image = Image<Intensity, Float>(width: 3,
                                                height: 3,
                                                data: [1.0, 2.0, 3.0,
                                                       4.0, 4.0, 2.0,
                                                       2.0, 1.0, 1.0])
            
            let integral = image.toIntegralImage()
            
            XCTAssertEqual(integral,
                           Image(width: 3,
                                 height: 3,
                                 data: [1.0, 3.0, 6.0,
                                        5.0, 11.0, 16.0,
                                        7.0, 14.0, 20.0]))
        }
    }
    
}
