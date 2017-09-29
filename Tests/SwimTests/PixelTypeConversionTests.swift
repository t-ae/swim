
import XCTest
import Swim

class PixelTypeConversionTests: XCTestCase {
    
    func testRGBtoRGBA() {
        let rgb = Image<RGB, Float>(width: 10, height: 10, data: [Float](repeating: 0, count: 10*10*3))
        let rgba = Image<RGBA, Float>(image: rgb, alpha: 0.5)
        
        XCTAssertEqual(rgba[channel: .red], rgb[channel: .red])
        XCTAssertEqual(rgba[channel: .green], rgb[channel: .green])
        XCTAssertEqual(rgba[channel: .blue], rgb[channel: .blue])
        XCTAssertEqual(rgba[channel: .alpha], Image<Intensity, Float>(width: 10, height: 10, value: 0.5))
    }
    
    func testARGBtoRGBA() {
        let argb = Image<ARGB, Float>(width: 10, height: 10, data: [Float](repeating: 0, count: 10*10*4))
        let rgba = Image<RGBA, Float>(image: argb)
        
        XCTAssertEqual(rgba[channel: .red], argb[channel: .red])
        XCTAssertEqual(rgba[channel: .green], argb[channel: .green])
        XCTAssertEqual(rgba[channel: .blue], argb[channel: .blue])
        XCTAssertEqual(rgba[channel: .alpha], argb[channel: .alpha])
    }
    
    func testRGBAtoARGB() {
        let rgba = Image<RGBA, Float>(width: 10, height: 10, data: [Float](repeating: 0, count: 10*10*4))
        let argb = Image<ARGB, Float>(image: rgba)
        
        XCTAssertEqual(argb[channel: .red], rgba[channel: .red])
        XCTAssertEqual(argb[channel: .green], rgba[channel: .green])
        XCTAssertEqual(argb[channel: .blue], rgba[channel: .blue])
        XCTAssertEqual(argb[channel: .alpha], rgba[channel: .alpha])
    }
}
