import XCTest
import Swim

class BlendVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension BlendVisualTests {
    func testBlends() {
        let lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena256 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
        var images: [Image<RGB, Double>] = []
        
        for mode in [BlendMode.multiply, .additive, .screen, .overlay] {
            var target = lena512
            target[128..<128+256, 128..<128+256].blend(image: lena256, mode: mode)
            images.append(target)
        }
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
