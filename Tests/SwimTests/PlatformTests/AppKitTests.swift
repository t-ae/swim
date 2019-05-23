import XCTest
import Swim

class AppKitTests: XCTestCase {
    var gray: Image<Gray, UInt8>!
    var rgba: Image<RGBA, UInt8>!
    
    override func setUp() {
        gray = Image(width: 256, height: 256, value: 255)
        rgba = Image(width: 256, height: 256, value: 255)
        
        let yRange = 0..<256
        
        var start = 0
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: 0))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 0, g: 0, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 255, g: 0, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 0, g: 255, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 0, g: 0, b: 255, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 255, g: 255, b: 0, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 0, g: 255, b: 255, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: UInt8(start)))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 255, g: 0, b: 255, a: 255))
        start += 32
        gray.drawRect(start..<start+32, yRange, color: Pixel(gray: 255))
        rgba.drawRect(start..<start+32, yRange, color: Pixel(r: 255, g: 255, b: 255, a: 255))
        start += 32
        
        rgba[channel: .alpha].drawRect(0..<256, 128..<256, color: Pixel(gray: 128))
    }
}

#if canImport(AppKit)

import AppKit

extension AppKitTests {
    func testGray() {
        let nsImage1 = gray.nsImage()
        let tmp = Image<Gray, UInt8>(nsImage: nsImage1)!
        let nsImage2 = tmp.nsImage()
        
        XCTAssertEqual(gray, tmp)
        
        XCTAssertFalse([nsImage1, nsImage2].isEmpty,
                       "Break and check image")
    }
    
    func testRGBA() {
        let nsImage1 = rgba.nsImage()
        let tmp = Image<RGBA, UInt8>(nsImage: nsImage1)!
        let nsImage2 = tmp.nsImage()
        
        XCTAssertEqual(rgba, tmp)
        
        XCTAssertFalse([nsImage1, nsImage2].isEmpty,
                       "Break and check image")
    }
    
    func testGrayDouble() {
        let nsImage1 = gray.nsImage()
        let tmp = Image<Gray, Double>(nsImage: nsImage1)!
        let nsImage2 = tmp.nsImage()
        
        XCTAssertFalse([nsImage1, nsImage2].isEmpty,
                       "Break and check image")
    }
    
    func testRGBADouble() {
        let nsImage1 = rgba.nsImage()
        let tmp = Image<RGBA, Double>(nsImage: nsImage1)!
        let nsImage2 = tmp.nsImage()
        
        XCTAssertFalse([nsImage1, nsImage2].isEmpty,
                       "Break and check image")
    }
    
    func testColorToGray() {
        let nsColor = rgba.nsImage()
        let gray = Image<Gray, Double>(nsImage: nsColor)!
        let nsGray = gray.nsImage()
        
        XCTAssertTrue(nsGray.isValid,
                       "Break and check image")
    }
    
    func testGrayToColor() {
        let nsGray = gray.nsImage()
        let color = Image<RGBA, Double>(nsImage: nsGray)!
        let nsColor = color.nsImage()
        
        XCTAssertTrue(nsColor.isValid,
                      "Break and check image")
    }
}

#endif

