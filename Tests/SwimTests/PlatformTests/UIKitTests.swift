import XCTest
import Swim

class UIKitTests: XCTestCase {
    
    var gray: Image<Gray, UInt8>!
    var rgba: Image<RGBA, UInt8>!
    
    override func setUp() {
        gray = Image(width: 256, height: 256, value: 255)
        rgba = Image(width: 256, height: 256, value: 255)
        
        var start = 0
        gray[cols: start..<start+32].fill(0)
        rgba[cols: start..<start+32].fill(Pixel(r: 0, g: 0, b: 0, a: 255))
        start += 32
        gray[cols: start..<start+32].fill(UInt8(start))
        rgba[cols: start..<start+32].fill(Pixel(r: 255, g: 0, b: 0, a: 255))
        start += 32
        gray[cols: start..<start+32].fill(UInt8(start))
        rgba[cols: start..<start+32].fill(Pixel(r: 0, g: 255, b: 0, a: 255))
        start += 32
        gray[cols: start..<start+32].fill(UInt8(start))
        rgba[cols: start..<start+32].fill(Pixel(r: 0, g: 0, b: 255, a: 255))
        start += 32
        gray[cols: start..<start+32].fill(UInt8(start))
        rgba[cols: start..<start+32].fill(Pixel(r: 255, g: 255, b: 0, a: 255))
        start += 32
        gray[cols: start..<start+32].fill(UInt8(start))
        rgba[cols: start..<start+32].fill(Pixel(r: 0, g: 255, b: 255, a: 255))
        start += 32
        gray[cols: start..<start+32].fill(UInt8(start))
        rgba[cols: start..<start+32].fill(Pixel(r: 255, g: 0, b: 255, a: 255))
        start += 32
        gray[cols: start..<start+32].fill(255)
        rgba[cols: start..<start+32].fill(Pixel(r: 255, g: 255, b: 255, a: 255))
        start += 32
        
        rgba[rows: 128..<256][channel: .alpha].fill(Pixel(gray: 128))
    }
}

#if canImport(UIKit)

extension UIKitTests {
    func testGray() {
        let uiImage1 = gray.uiImage()
        let tmp = Image<Gray, UInt8>(uiImage: uiImage1)!
        let uiImage2 = tmp.uiImage()
        
        XCTAssertFalse([uiImage1, uiImage2].isEmpty,
                       "Break and check image")
    }
    
    func testRGBA() {
        let uiImage1 = rgba.uiImage()
        let tmp = Image<RGBA, UInt8>(uiImage: uiImage1)!
        let uiImage2 = tmp.uiImage()
        
        XCTAssertFalse([uiImage1, uiImage2].isEmpty,
                       "Break and check image")
    }
    
    func testGrayDouble() {
        let uiImage1 = gray.uiImage()
        let tmp = Image<Gray, Double>(uiImage: uiImage1)!
        let uiImage2 = tmp.uiImage()
        
        XCTAssertFalse([uiImage1, uiImage2].isEmpty,
                       "Break and check image")
    }
    
    func testRGBADouble() {
        let uiImage1 = rgba.uiImage()
        let tmp = Image<RGBA, Double>(uiImage: uiImage1)!
        let uiImage2 = tmp.uiImage()
        
        XCTAssertFalse([uiImage1, uiImage2].isEmpty,
                       "Break and check image")
    }
}

#endif
