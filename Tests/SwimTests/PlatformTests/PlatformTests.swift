import XCTest
import Swim

class PlatformTests: XCTestCase {
    let rgbaPath = testResoruceRoot().appendingPathComponent("lena_512.png")
    let grayPath = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
}

#if canImport(AppKit)

import AppKit

extension PlatformTests {
    func testGray() {
        let image = try! Image<Intensity, UInt8>(contentsOf: grayPath)
        
        let nsImage1 = image.nsImage()
        
        let image2 = Image<Intensity, UInt8>(nsImage: nsImage1)!
        let nsImage2 = image2.nsImage()
        
        XCTAssertTrue(nsImage1.isValid && nsImage2.isValid,
                      "Break and check image")
    }
    
    func testRGBA() {
        let baseImage = NSImage(contentsOf: rgbaPath)!
        
        let image = Image<RGBA, UInt8>(nsImage: baseImage)!
        
        let nsImage1 = image.nsImage()
        
        let image2 = Image<RGBA, UInt8>(nsImage: nsImage1)!
        let nsImage2 = image2.nsImage()
        
        XCTAssertTrue(nsImage1.isValid && nsImage2.isValid,
                      "Break and check image")
    }
}

#endif

