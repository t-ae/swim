import XCTest
import Swim

class SkeletonizerVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension SkeletonizerVisualTests {
    func testSkeletonize() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 50) else {
            XCTFail("Font not found.")
            return
        }
        let image = Image.createTextImage(text: """
            abcdefghijklmnopqrstuvwxyz
            ABCDEFGHIJKLMNOPQRSTUVWXYZ
            """, font: font)
        let boolImage = image.createMask { pixel in pixel[.gray] > 128 }
        
        let result = Skeletonizer.skeletonize(image: boolImage)
        
        let ns = result.dataConverted { $0 ? UInt8(255): 0 }.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
