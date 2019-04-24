import XCTest
import Swim

class PaddingTests: XCTestCase {
    func testPadding() {
        let image = Image(width: 2, height: 2, rgb: [0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3])
        let pixel = Pixel(rgb: [4, 5, 6])
        let padded = Image(image: image, with: ((1, 2), (3, 4)), paddingPixel: pixel)
        
        XCTAssertEqual(padded[1..<3, 3..<5], image)
        
        for y in 0..<padded.height {
            for x in 0..<padded.width {
                if (3..<5).contains(y) && (1..<3).contains(x) {
                    continue
                }
                XCTAssertEqual(padded[x, y], pixel)
            }
        }
    }
}
