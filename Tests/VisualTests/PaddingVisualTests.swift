import XCTest
import Swim

class PaddingVisualTests: XCTestCase {

    func testPadding() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGBA, UInt8>(contentsOf: path)
        
        var images = [Image<RGBA, UInt8>]()
        
        images.append(lena.withPadding(50, edgeMode: .zero))
        images.append(lena.withPadding(((100, 0), (50, 50)), edgeMode: .edge))
        images.append(lena.withPadding(((50, 50), (100, 0)), edgeMode: .symmetric))
        images.append(lena.withPadding(((10, 90), (10, 90)), edgeMode: .wrap))
        images.append(lena.withPadding((20, 50), edgeMode: .reflect))
        
        let image = Image.concatH(images)
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break")
    }

}
