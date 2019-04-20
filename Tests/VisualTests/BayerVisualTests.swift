import XCTest
import Swim

class BayerVisualTests: XCTestCase {
    
    var lena = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))

    func testBGGR() {
        let conv = BayerConverter(pattern: .bggr)
        
        let nsImage0 = doubleToNSImage(lena)
        
        let gray = conv.convert(image: lena)
        
        let nsImage1 = doubleToNSImage(gray)
        
        let color = conv.demosaic(image: gray)
        
        let nsImage2 = doubleToNSImage(color)
        
        XCTAssertTrue(nsImage0.isValid && nsImage1.isValid && nsImage2.isValid,
                      "Break and check nsImages")
    }
    
    func testGBRG() {
        let conv = BayerConverter(pattern: .gbrg)
        
        let nsImage0 = doubleToNSImage(lena)
        
        let gray = conv.convert(image: lena)
        
        let nsImage1 = doubleToNSImage(gray)
        
        let color = conv.demosaic(image: gray)
        
        let nsImage2 = doubleToNSImage(color)
        
        XCTAssertTrue(nsImage0.isValid && nsImage1.isValid && nsImage2.isValid,
                      "Break and check nsImages")
    }
    
    func testGRBG() {
        let conv = BayerConverter(pattern: .grbg)
        
        let nsImage0 = doubleToNSImage(lena)
        
        let gray = conv.convert(image: lena)
        
        let nsImage1 = doubleToNSImage(gray)
        
        let color = conv.demosaic(image: gray)
        
        let nsImage2 = doubleToNSImage(color)
        
        XCTAssertTrue(nsImage0.isValid && nsImage1.isValid && nsImage2.isValid,
                      "Break and check nsImages")
    }
    
    func testRGGB() {
        let conv = BayerConverter(pattern: .rggb)
        
        let nsImage0 = doubleToNSImage(lena)
        
        let gray = conv.convert(image: lena)
        
        let nsImage1 = doubleToNSImage(gray)
        
        let color = conv.demosaic(image: gray)
        
        let nsImage2 = doubleToNSImage(color)
        
        XCTAssertTrue(nsImage0.isValid && nsImage1.isValid && nsImage2.isValid,
                      "Break and check nsImages")
    }
}
