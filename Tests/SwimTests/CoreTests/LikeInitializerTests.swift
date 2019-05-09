import XCTest
import Swim

class LikeInitializerTests: XCTestCase {

    func testLike() {
        let baseImage = Image<RGB, Double>(width: 100, height: 100, value: 1)
        do {
            let zeros = Image.full(value: 0, like: baseImage)
            XCTAssertEqual(zeros.width, baseImage.width)
            XCTAssertEqual(zeros.height, baseImage.height)
            XCTAssertTrue(zeros
                .withUnsafeBufferPointer { Array($0) }
                .allSatisfy { $0 == 0 })
        }
        do {
            let trues = Image<Intensity, Bool>.full(value: true, like: baseImage)
            XCTAssertEqual(trues.width, baseImage.width)
            XCTAssertEqual(trues.height, baseImage.height)
            XCTAssertTrue(trues
                .withUnsafeBufferPointer { Array($0) }
                .allSatisfy { $0 })
        }
    }
    
}
