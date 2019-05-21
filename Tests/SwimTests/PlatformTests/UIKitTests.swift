import XCTest
import Swim

class UIKitTests: XCTestCase {
    
    var gray: Image<Gray, UInt8>!
    var rgba: Image<RGBA, UInt8>!
    
    override func setUp() {
        gray = Image(width: 256, height: 256, value: 255)
        rgba = Image(width: 256, height: 256, value: 255)
        
        let yRange = 0..<256
        
        var start = 0
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: 0))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 0, g: 0, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 255, g: 0, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 0, g: 255, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 0, g: 0, b: 255, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 255, g: 255, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 0, g: 255, b: 255, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 255, g: 0, b: 255, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, pixel: Pixel(gray: 255))
        rgba.drawRect(start..<start+32, yRange, pixel: Pixel(r: 255, g: 255, b: 255, a: 255))
        start += 32
        
        rgba[channel: .alpha].drawRect(0..<256, 128..<256, pixel: Pixel(gray: 128))
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
