import XCTest
import Swim

class MutablePixelRefArithmeticTests: XCTestCase {
    func testAdd() {
        var image = Image(width: 2, height: 2, rgba: (0..<2*2*4).map { UInt8($0) })
        var answer = image
        
        image.withMutablePixelRef(x: 0, y: 0) { ref in
            ref += 1
        }
        
        answer[0, 0] += 1
        
        XCTAssertEqual(image, answer)
    }
}
