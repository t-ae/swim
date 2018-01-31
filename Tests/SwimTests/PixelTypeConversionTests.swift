
import XCTest
import Swim

class PixelTypeConversionTests: XCTestCase {
    
    func testRGBtoRGBA() {
        let data = (0..<27).map { Float($0) }
        let rgb = Image<RGB, Float>(width: 3, height: 3, data: data)
        let rgba = Image<RGBA, Float>(image: rgb, alpha: 0.5)

        XCTAssertEqual(rgba[channel: .red], rgb[channel: .red])
        XCTAssertEqual(rgba[channel: .green], rgb[channel: .green])
        XCTAssertEqual(rgba[channel: .blue], rgb[channel: .blue])
        XCTAssertEqual(rgba[channel: .alpha], Image<Intensity, Float>(width: 3, height: 3, value: 0.5))
    }
    
    func testRGBAtoRGB() {
        let data = (0..<36).map { Float($0) }
        let rgba = Image<RGBA, Float>(width: 3, height: 3, data: data)
        let rgb = Image<RGB, Float>(image: rgba)

        XCTAssertEqual(rgb[channel: .red], rgba[channel: .red])
        XCTAssertEqual(rgb[channel: .green], rgba[channel: .green])
        XCTAssertEqual(rgb[channel: .blue], rgba[channel: .blue])
    }
    
    func testARGBtoRGBA() {
        let data = (0..<36).map { Float($0) }
        let argb = Image<ARGB, Float>(width: 3, height: 3, data: data)
        let rgba = Image<RGBA, Float>(image: argb)

        XCTAssertEqual(rgba[channel: .red], argb[channel: .red])
        XCTAssertEqual(rgba[channel: .green], argb[channel: .green])
        XCTAssertEqual(rgba[channel: .blue], argb[channel: .blue])
        XCTAssertEqual(rgba[channel: .alpha], argb[channel: .alpha])
    }
    
    func testRGBAtoARGB() {
        let data = (0..<36).map { Float($0) }
        let rgba = Image<RGBA, Float>(width: 3, height: 3, data: data)
        let argb = Image<ARGB, Float>(image: rgba)

        XCTAssertEqual(argb[channel: .red], rgba[channel: .red])
        XCTAssertEqual(argb[channel: .green], rgba[channel: .green])
        XCTAssertEqual(argb[channel: .blue], rgba[channel: .blue])
        XCTAssertEqual(argb[channel: .alpha], rgba[channel: .alpha])
    }
}
