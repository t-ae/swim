import XCTest
import Swim

class BayerVisualTests: XCTestCase {
    
    var lena = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
}

#if canImport(AppKit)

extension BayerVisualTests {
    func testBGGR() {
        let conv = BayerConverter(pattern: .bggr)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testGBRG() {
        let conv = BayerConverter(pattern: .gbrg)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testGRBG() {
        let conv = BayerConverter(pattern: .grbg)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testRGGB() {
        let conv = BayerConverter(pattern: .rggb)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
}

#endif
