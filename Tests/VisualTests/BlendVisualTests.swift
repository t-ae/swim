import XCTest
import Swim

class BlendVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension BlendVisualTests {
    func testAlphaBlend() {
        var imageBase = Image<RGBA, Double>(width: 500,
                                           height: 500,
                                           value: 0.9)
        
        var red = Image.full(value: 0, like: imageBase)
        red.drawCircle(center: (250, 200), radius: 100, pixel: Pixel(r: 1, g: 0, b: 0, a: 1))
        red.drawCircle(center: (250, 200), radius: 95, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.5))
        
        var green = Image.full(value: 0, like: imageBase)
        green.drawCircle(center: (200, 300), radius: 100, pixel: Pixel(r: 0, g: 1, b: 0, a: 1))
        green.drawCircle(center: (200, 300), radius: 95, pixel: Pixel(r: 0, g: 1, b: 0, a: 0.5))
        
        var blue = Image.full(value: 0, like: imageBase)
        blue.drawCircle(center: (300, 300), radius: 100, pixel: Pixel(r: 0, g: 0, b: 1, a: 1))
        blue.drawCircle(center: (300, 300), radius: 95, pixel: Pixel(r: 0, g: 0, b: 1, a: 0.5))
        
        Blender.alphaBlend(top: red, bottom: &imageBase)
        Blender.alphaBlend(top: green, bottom: &imageBase)
        Blender.alphaBlend(top: blue, bottom: &imageBase)
        
        let nsImage = doubleToNSImage(imageBase)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testMultiplyBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        var circle = Image<RGBA, Double>.full(value: 0, like: lena128)
        circle.drawCircle(center: (64, 64), radius: 63, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.6))
        circle.drawCircle(center: (64, 64), radius: 55, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.3))
        
        Blender.multiplyBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.multiplyBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testAdditiveBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        var circle = Image<RGBA, Double>.full(value: 0, like: lena128)
        circle.drawCircle(center: (64, 64), radius: 63, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.6))
        circle.drawCircle(center: (64, 64), radius: 55, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.3))
        
        Blender.additiveBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.additiveBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testScreenBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        var circle = Image<RGBA, Double>.full(value: 0, like: lena128)
        circle.drawCircle(center: (64, 64), radius: 63, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.6))
        circle.drawCircle(center: (64, 64), radius: 55, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.3))
        
        Blender.screenBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.screenBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testOverlayBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        var circle = Image<RGBA, Double>.full(value: 0, like: lena128)
        circle.drawCircle(center: (64, 64), radius: 63, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.6))
        circle.drawCircle(center: (64, 64), radius: 55, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.3))
        
        Blender.overlayBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.overlayBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func test4Blends() {
        let lena = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
        var circle = Image<RGBA, Double>.full(value: 0, like: lena)
        circle.drawCircle(center: (128, 128), radius: 127, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.6))
        circle.drawCircle(center: (128, 128), radius: 120, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.3))
        var images: [[Image<RGB, Double>]] = [[lena, lena], [lena, lena]]
        
        Blender.additiveBlend(top: circle, bottom: &images[0][0])
        Blender.multiplyBlend(top: circle, bottom: &images[0][1])
        Blender.screenBlend(top: circle, bottom: &images[1][0])
        Blender.overlayBlend(top: circle, bottom: &images[1][1])
        
        let lena4 = Image.concat(images)
        let nsImage = doubleToNSImage(lena4)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}

#endif
