import XCTest
import Swim

class PaddingVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension PaddingVisualTests {
    func testPadding() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGBA, UInt8>(contentsOf: path)
        
        var images = [Image<RGBA, UInt8>]()
        
        images.append(lena.withPadding(50, edgeMode: .zero))
        images.append(lena.withPadding(left: 100, right: 0, top: 50, bottom: 50, edgeMode: .edge))
        images.append(lena.withPadding(left: 50, right: 50, top: 100, bottom: 0, edgeMode: .symmetric))
        images.append(lena.withPadding(left: 10, right: 90, top: 10, bottom: 90, edgeMode: .wrap))
        images.append(lena.withPadding(x: 20, y: 50, edgeMode: .reflect))
        
        let image = Image.concatH(images)
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break")
    }
}

#endif
