import XCTest
import Swim

class ConvolutionTests: XCTestCase {
    
    func testConvoluted() {
        do {
            let image = Image(width: 3, height: 2, intensity: [0, 1, 2,
                                                               3, 4, 5])
            
            let filtered = image.convoluted(Filter.sobel3x3H)
            
            XCTAssertEqual(filtered, Image(width: 3, height: 2, data: [4, 8, 4,
                                                                       4, 8, 4]))
        }
        do {
            let image = Image(width: 3, height: 2, intensity: [0, 1, 2,
                                                               3, 4, 5])
            
            let filtered = image.convoluted(Filter.sobel3x3H)
            
            XCTAssertEqual(filtered, Image(width: 3, height: 2, data: [4, 8, 4,
                                                                       4, 8, 4]))
        }
    }
    
}
