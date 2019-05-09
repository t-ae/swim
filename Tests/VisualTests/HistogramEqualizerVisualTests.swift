import XCTest
import Swim

class HistogramEqualizerVisualTests: XCTestCase {
    func testHistogramEqualizer() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Intensity, UInt8>(contentsOf: path)
        
        let eq = HistogramEqualizer.equalize(image: lena)
        
        let image = Image.concatH([lena, eq])
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break")
    }
}
