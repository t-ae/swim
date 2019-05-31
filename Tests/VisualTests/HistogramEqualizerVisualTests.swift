import XCTest
import Swim

class HistogramEqualizerVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension HistogramEqualizerVisualTests {
    func testHistogramEqualizer() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena = try! Image<RGB, UInt8>(contentsOf: path)
        lena.dataConvert { UInt8(pow(Double($0), 2) / 255) }
        
        var eq = lena
        Histograms.equalize(image: &eq)
        
        let image = Image.concatH([lena, eq])
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testHistogramEqualizerInt() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena_uint8 = try! Image<RGB, UInt8>(contentsOf: path)
        lena_uint8.dataConvert { UInt8(pow(Double($0), 2) / 255) }
        let lena = lena_uint8.cast(to: Int.self)
        
        var eq = lena
        Histograms.equalize(image: &eq)
        
        let image = Image.concatH([lena, eq])
        let ns = image.cast(to: UInt8.self).nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testHistogramEqualizerColor() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        var lena = try! Image<RGB, UInt8>(contentsOf: path)
        lena.dataConvert { UInt8(pow(Double($0), 2) / 255) }
        
        // each channel
        var eq1 = lena
        Histograms.equalize(image: &eq1[channel: .red])
        Histograms.equalize(image: &eq1[channel: .green])
        Histograms.equalize(image: &eq1[channel: .blue])
        
        // three color histogram
        var eq2 = lena
        Histograms.equalize(image: &eq2)
        
        let image = Image.concatH([lena, eq1, eq2])
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
