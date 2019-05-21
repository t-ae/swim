import XCTest
import Swim

class BlendVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension BlendVisualTests {
    func testMultiplyBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena256 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
        
        lena512[128..<128+256, 128..<128+256].blend(image: lena256, mode: .multiply)
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testAdditiveBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena256 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
        
        lena512[128..<128+256, 128..<128+256].blend(image: lena256, mode: .additive)
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testScreenBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena256 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
        
        lena512[128..<128+256, 128..<128+256].blend(image: lena256, mode: .screen)
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testOverlayBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena256 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
        
        lena512[128..<128+256, 128..<128+256].blend(image: lena256, mode: .overlay)
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}

#endif
