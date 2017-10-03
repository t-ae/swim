
import XCTest
@testable import Swim

class SequencePerformanceTests: XCTestCase {
    
    func testImageSequence() {
        do {
            let image = Image<Intensity, UInt8>(width: 2, height: 2, data: [0, 1, 2, 3])
            XCTAssertEqual(image.pixels().map { $0 },
                           [Pixel(0), Pixel(1), Pixel(2), Pixel(3)])
        }
        do {
            let image = Image<RGBA, Double>(width: 2, height: 2, data: (0..<16).map(Double.init))
            XCTAssertEqual(image.pixels().map { $0 },
                           [Pixel(r: 0, g: 1, b: 2, a: 3),
                            Pixel(r: 4, g: 5, b: 6, a: 7),
                            Pixel(r: 8, g: 9, b: 10, a: 11),
                            Pixel(r: 12, g: 13, b: 14, a: 15)])
        }
    }
}
