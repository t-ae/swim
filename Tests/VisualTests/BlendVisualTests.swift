import XCTest
import Swim

class BlendVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension BlendVisualTests {
    func testAlphaBlend() {
        var imageBase = Image<RGB, Double>(width: 500,
                                           height: 500,
                                           value: 1)
        
        let red = Shape.circle(size: 200,
                               lineWidth: 3,
                               lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 1.0),
                               fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.5))
        let green = Shape.circle(size: 200,
                                 lineWidth: 3,
                                 lineColor: Pixel(r: 0.0, g: 1.0, b: 0.0, a: 1.0),
                                 fillColor: Pixel(r: 0.0, g: 1.0, b: 0.0, a: 0.5))
        let blue = Shape.circle(size: 200,
                                lineWidth: 3,
                                lineColor: Pixel(r: 0.0, g: 0.0, b: 1.0, a: 1.0),
                                fillColor: Pixel(r: 0.0, g: 0.0, b: 1.0, a: 0.5))
        
        Blender.alphaBlend(src: red, dst: &imageBase[150..<350, 100..<300])
        Blender.alphaBlend(src: green, dst: &imageBase[100..<300, 200..<400])
        Blender.alphaBlend(src: blue, dst: &imageBase[200..<400, 200..<400])
        
        let nsImage = doubleToNSImage(imageBase)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testMultiplyBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        let circle = Shape.circle(size: 128,
                                  lineWidth: 10,
                                  lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.6),
                                  fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.3))
        
        Blender.multiplyBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.multiplyBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testAddBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        let circle = Shape.circle(size: 128,
                                  lineWidth: 10,
                                  lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.6),
                                  fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.3))
        
        Blender.addBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.addBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testScreenBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        let circle = Shape.circle(size: 128,
                                  lineWidth: 10,
                                  lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.6),
                                  fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.3))
        
        Blender.screenBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.screenBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testOverlayBlend() {
        var lena512 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_512.png"))
        let lena128 = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        let circle = Shape.circle(size: 128,
                                  lineWidth: 10,
                                  lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.6),
                                  fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.3))
        
        Blender.overlayBlend(top: lena128, bottom: &lena512[128..<256, 128..<256])
        Blender.overlayBlend(top: circle, bottom: &lena512[256..<384, 256..<384])
        
        let nsImage = doubleToNSImage(lena512)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func test4Blends() {
        let lena = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_128.png"))
        let circle = Shape.circle(size: 128,
                                  lineWidth: 10,
                                  lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.6),
                                  fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.3))
        var images: [[Image<RGB, Double>]] = [[lena, lena], [lena, lena]]
        
        Blender.addBlend(top: circle, bottom: &images[0][0])
        Blender.multiplyBlend(top: circle, bottom: &images[0][1])
        Blender.screenBlend(top: circle, bottom: &images[1][0])
        Blender.overlayBlend(top: circle, bottom: &images[1][1])
        
        let lena4 = Image.concat(images)
        let nsImage = doubleToNSImage(lena4)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}

#endif
