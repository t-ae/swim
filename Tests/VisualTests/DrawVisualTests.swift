import XCTest
import Swim

class DrawVisualTests: XCTestCase {

    func testDrawLine() {
        var image = Image<Gray, UInt8>(width: 201, height: 201, value: 0)
        
        image.drawLine(p1: (50, 0), p2: (150, 200), pixel: Pixel(gray: 255))
        image.drawLine(p1: (150, 0), p2: (50, 200), pixel: Pixel(gray: 255))
        
        image.drawLine(p1: (0, 50), p2: (200, 150), pixel: Pixel(gray: 255))
        image.drawLine(p1: (0, 150), p2: (200, 50), pixel: Pixel(gray: 255))
        
        image.drawLine(p1: (100, 0), p2: (100, 200), pixel: Pixel(gray: 255))
        image.drawLine(p1: (0, 100), p2: (200, 100), pixel: Pixel(gray: 255))
        
        image.drawLines(points: [(10, 10), (190, 190), (190, 10), (10, 190)], pixel: Pixel(gray: 128))
        
        image.drawX(center: (60, 10), size: 5, pixel: Pixel(gray: 192))
        image.drawX(center: (70, 10), size: 6, pixel: Pixel(gray: 192))
        
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }

    func testDrawCircle() {
        var image = Image<Gray, UInt8>(width: 201, height: 201, value: 0)
        
        image.drawCircle(center: (100, 100), radius: 112, pixel: Pixel(value: 96))
        image.drawCircle(center: (50, 50), radius: 50, pixel: Pixel(value: 192))
        
        image.drawCirclePelimeter(center: (100, 100), radius: 30, pixel: Pixel(value: 255))
        
        image.drawCirclePelimeter(center: (150, 150), radius: 70, pixel: Pixel(value: 255))
        
        let ns = image.nsImage()
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testDrawRect() {
        var image = Image<Gray, UInt8>(width: 201, height: 201, value: 0)
        
        image.drawRectPelimeter(origin: (0, 0), size: (100, 100), pixel: Pixel(gray: 128))
        image.drawRectPelimeter(origin: (30, 30), size: (200, 200), pixel: Pixel(gray: 192))
        image.drawRectPelimeter(origin: (-30, -30), size: (200, 200), pixel: Pixel(gray: 255))
        
        image.drawRect(origin: (100, 100), size: (10, 10), pixel: Pixel(gray: 64))
        image.drawRect(origin: (180, -10), size: (30, 30), pixel: Pixel(gray: 64))
        image.drawRect(origin: (-10, 180), size: (30, 30), pixel: Pixel(gray: 64))
        
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testDrawPolygon() {
        var image = Image<Gray, UInt8>(width: 201, height: 201, value: 0)
        
        // clockwise
        image.drawPolygon(points: [(0, 30), (15, 0), (30, 25)], pixel: Pixel(gray: 255))
        // counter clockwise
        image.drawPolygon(points: [(110, 30), (130, 25), (115, 0)], pixel: Pixel(gray: 255))
        // not convex
        image.drawPolygon(points: [(0, 130), (30, 200), (60, 130), (30, 170)], pixel: Pixel(gray: 255))
        image.drawPolygon(points: [(100, 200), (130, 150), (100, 100), (150, 130), (200, 100), (170, 150), (200, 200), (150, 170)], pixel: Pixel(gray: 255))
        
        // self-intersecting
        image.drawPolygon(points: [(50, 50), (100, 50), (50, 100), (100, 100)], pixel: Pixel(gray: 255))
        
        // zigzag
        image.drawPolygon(points: [(100, 90), (200, 90), (200, 50), (190, 80), (180, 50), (170, 80), (160, 50), (150, 80), (140, 50), (130, 80), (120, 50), (110, 80), (100, 50)], pixel: Pixel(gray: 255))
        
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testDrawImage() {
        var image = Image<Gray, UInt8>(width: 201, height: 201, value: 0)
        let draw = Image<Gray, UInt8>(width: 50, height: 50, value: 255)
        
        let mask = Image<Gray, Bool>(width: 5,
                                     height: 5,
                                     data: [true, true, true, true, true,
                                            true, false, false, false, false,
                                            true, true, true, true, true,
                                            false, false, false, false, true,
                                            true, true, true, true, true])
            .resize(width: draw.width, height: draw.height)
        
        image.drawImage(origin: (50, 50), image: draw)
        image.drawImage(origin: (130, 130), image: draw, mask: mask)
        
        image.drawImage(origin: (-5, -5), image: draw, mask: mask)
        image.drawImage(origin: (170, -5), image: draw, mask: mask)
        image.drawImage(origin: (-5, 170), image: draw, mask: mask)
        image.drawImage(origin: (170, 170), image: draw, mask: mask)
        
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testDrawImageAlphaBlend() {
        var imageBase = Image<RGB, Double>(width: 500,
                                            height: 500,
                                            value: 0.9)
        
        var red = Image<RGBA, Double>(width: 201, height: 201, value: 0)
        red.drawCircle(center: (100, 100), radius: 100, pixel: Pixel(r: 1, g: 0, b: 0, a: 1))
        red.drawCircle(center: (100, 100), radius:  95, pixel: Pixel(r: 1, g: 0, b: 0, a: 0.5))
        
        var green = Image<ARGB, Double>(width: 201, height: 201, value: 0)
        green.drawCircle(center: (100, 100), radius: 100, pixel: Pixel(a: 1.0, r: 0, g: 1, b: 0))
        green.drawCircle(center: (100, 100), radius:  95, pixel: Pixel(a: 0.5, r: 0, g: 1, b: 0))
        
        var blue = Image<RGBA, Double>(width: 201, height: 201, value: 0)
        blue.drawCircle(center: (100, 100), radius: 100, pixel: Pixel(r: 0, g: 0, b: 1, a: 1))
        blue.drawCircle(center: (100, 100), radius:  95, pixel: Pixel(r: 0, g: 0, b: 1, a: 0.5))
        
        imageBase.drawImage(origin: (150, 100), image: red)
        imageBase.drawImage(origin: (100, 200), image: green)
        imageBase.drawImage(origin: (200, 200), image: blue)
        
        let nsImage = doubleToNSImage(imageBase)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testDrawImageAlphaBlending_gray() {
        var imageBase = Image<GrayAlpha, Double>(width: 500,
                                                 height: 500,
                                                 value: 0)
        
        var circle = Image<GrayAlpha, Double>(width: 201, height: 201, value: 0)
        circle.drawCircle(center: (100, 100), radius: 100, pixel: Pixel(gray: 1, alpha: 1.0))
        circle.drawCircle(center: (100, 100), radius:  95, pixel: Pixel(gray: 1, alpha: 0.5))
        
        imageBase.drawImage(origin: (150, 100), image: circle)
        imageBase.drawImage(origin: (100, 200), image: circle)
        imageBase.drawImage(origin: (200, 200), image: circle)
        
        let nsImage = doubleToNSImage(imageBase.toRGBA())
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testCreateTextImage() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/ヒラギノ明朝 ProN.ttc"), fontSize: 50) else {
            XCTFail("Font not found.")
            return
        }
        let image = Image.createTextImage(text: """
            abcdefghijklmnopqrstuvwxyz
            ABCDEFGHIJKLMNOPQRSTUVWXYZ
            あいうえお阿伊宇江於
            AWAWAWAWAW
            """, font: font)
        
        let nsImage = image.nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testDrawText() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 30) else {
            XCTFail("Font not found.")
            return
        }
        guard let font2 = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/ヒラギノ明朝 ProN.ttc"), fontSize: 20) else {
            XCTFail("Font not found.")
            return
        }
        
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        var lena = try! Image<RGB, Double>(contentsOf: path)
        
        let size = Image.getTextImageSize(text: "LENA", font: font)
        
        lena.drawText(origin: (0, 0), text: "LENA", font: font, pixel: Pixel(r: 0, g: 0, b: 0, a: 1))
        lena.drawText(origin: (50, 50), text: "LENA", font: font, pixel: Pixel(r: 0, g: 0, b: 1, a: 0.7))
        
        lena.drawText(origin: (511-size.width, 256), text: "LENA", font: font, pixel: Pixel(r: 0, g: 1, b: 1, a: 0.7))
        
        lena.drawText(origin: (-30, 256), text: "LENA", font: font, pixel: Pixel(r: 1, g: 1, b: 1, a: 0.7))
        
        let lorem = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
        Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        
        lena.drawText(origin: (0, 300),
                      text: lorem,
                      font: font2,
                      lineGap: 0,
                      pixel: Pixel(r: 0, g: 0, b: 0, a: 1))
        
        let nsImage = doubleToNSImage(lena)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}
