import XCTest
import Swim

class TransformationVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension TransformationVisualTests {
    func testTransform() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        var images: [Image<RGB, Double>] = [lena]
        
        images.append(lena.flipLR())
        images.append(lena.flipUD())
        images.append(lena.rot90())
        images.append(lena.rot180())
        images.append(lena.rot270())
        images.append(lena.transposed())
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
