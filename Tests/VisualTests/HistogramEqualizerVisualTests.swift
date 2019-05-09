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
    
    func testHistogramEqualizerInt() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena_uint8 = try! Image<Intensity, UInt8>(contentsOf: path)
        let lena = Image(cast: lena_uint8, to: Int.self)
        
        let eq = HistogramEqualizer.equalize(image: lena)
        
        let image = Image.concatH([lena, eq])
        let ns = Image(cast: image, to: UInt8.self).nsImage()
        
        XCTAssertTrue(ns.isValid, "break")
    }
}
