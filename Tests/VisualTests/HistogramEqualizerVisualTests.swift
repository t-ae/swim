import XCTest
import Swim

class HistogramEqualizerVisualTests: XCTestCase {
    func testHistogramEqualizer() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena = try! Image<RGB, UInt8>(contentsOf: path)
        lena.channelwiseConvert { UInt8(255 * pow(Double($0), 2) / pow(255, 2)) }
        
        let eq = HistogramEqualizer.equalize(image: lena)
        
        let image = Image.concatH([lena, eq])
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break")
    }
    
    func testHistogramEqualizerInt() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena_uint8 = try! Image<RGB, UInt8>(contentsOf: path)
        lena_uint8.channelwiseConvert { UInt8(255 * pow(Double($0), 2) / pow(255, 2)) }
        let lena = Image(cast: lena_uint8, to: Int.self)
        
        
        let eq = HistogramEqualizer.equalize(image: lena)
        
        let image = Image.concatH([lena, eq])
        let ns = Image(cast: image, to: UInt8.self).nsImage()
        
        XCTAssertTrue(ns.isValid, "break")
    }
    
    func testHistogramEqualizerColor() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        var lena = try! Image<RGB, UInt8>(contentsOf: path)
        lena.channelwiseConvert { UInt8(255 * pow(Double($0), 2) / pow(255, 2)) }
        
        // each channel respectively
        var eq1 = lena
        eq1[channel: .red] = HistogramEqualizer.equalize(image: eq1[channel: .red])
        eq1[channel: .green] = HistogramEqualizer.equalize(image: eq1[channel: .green])
        eq1[channel: .blue] = HistogramEqualizer.equalize(image: eq1[channel: .blue])
        
        // three color histogram
        let eq2 = HistogramEqualizer.equalize(image: lena)
        
        let image = Image.concatH([lena, eq1, eq2])
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break")
    }
}
