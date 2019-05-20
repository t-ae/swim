import XCTest
import Swim

class PaddingTests: XCTestCase {
    func testConstantPadding() {
        let image = Image(width: 2, height: 2, rgb: [0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3])
        let pixel = Pixel(rgb: [4, 5, 6])
        let padded = image.withPadding(left: 1, right: 2, top: 3, bottom: 4, edgeMode: .constant(pixel: pixel))
        
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
    
    func testSymmetricPadding() {
        let image = Image(width: 2, height: 2, rgb: [0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3])
        let padded = image.withPadding(2, edgeMode: .symmetric)
        
        var answer = Image<RGB, Int>(width: 6, height: 6, value: 0)
        answer[0..<2, 0..<2] = image.flipLR().flipUD()
        answer[2..<4, 0..<2] = image.flipUD()
        answer[4..<6, 0..<2] = image.flipLR().flipUD()
        answer[0..<2, 2..<4] = image.flipLR()
        answer[2..<4, 2..<4] = image
        answer[4..<6, 2..<4] = image.flipLR()
        answer[0..<2, 4..<6] = image.flipLR().flipUD()
        answer[2..<4, 4..<6] = image.flipUD()
        answer[4..<6, 4..<6] = image.flipLR().flipUD()
        
        XCTAssertEqual(padded, answer)
    }
    
    func testZeroPadding() {
        let image = Image(width: 2, height: 2, rgb: [0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3])
        let padded = image.withPadding(0, edgeMode: .symmetric)
        
        XCTAssertEqual(padded, image)
    }
}
