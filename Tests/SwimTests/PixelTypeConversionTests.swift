
import XCTest
import Swim

class PixelTypeConversionTests: XCTestCase {
    
    func testToBrightness() {
        do {
            let data = (0..<27).map { Int($0) }
            let rgb = Image<RGB, Int>(width: 3, height: 3, data: data)
            
            let brightness = rgb.toBrightness()
            XCTAssertEqual(brightness, Image(width: 3, height: 3, data: [1, 4, 7, 10, 13, 16, 19, 22, 25]))
        }
        do {
            let data = (0..<27).map { Double($0) }
            let rgb = Image<RGB, Double>(width: 3, height: 3, data: data)
            
            let brightness = rgb.toBrightness()
            XCTAssertEqual(brightness, Image(width: 3, height: 3, data: [1, 4, 7, 10, 13, 16, 19, 22, 25]))
        }
    }
    
    func testIntensityToRGB() {
        do {
            let data = (0..<9).map { UInt8($0) }
            let intensity = Image<Intensity, UInt8>(width: 3, height: 3, data: data)
            
            XCTAssertEqual(intensity.toRGB(),
                           Image(width: 3,
                                 height: 3,
                                 data: [0, 0, 0, 1, 1, 1, 2, 2, 2,
                                        3, 3, 3, 4, 4, 4, 5, 5, 5,
                                        6, 6, 6, 7, 7, 7, 8, 8, 8]))
        }
        do {
            let data = (0..<9).map { Double($0) }
            let intensity = Image<Intensity, Double>(width: 3, height: 3, data: data)
            
            XCTAssertEqual(intensity.toRGB(),
                           Image(width: 3,
                                 height: 3,
                                 data: [0, 0, 0, 1, 1, 1, 2, 2, 2,
                                        3, 3, 3, 4, 4, 4, 5, 5, 5,
                                        6, 6, 6, 7, 7, 7, 8, 8, 8]))
        }
    }
    
    func testRGBtoRGBA() {
        do {
            let data = (0..<27).map { Int($0) }
            let rgb = Image<RGB, Int>(width: 3, height: 3, data: data)
            let rgba = Image<RGBA, Int>(image: rgb, alpha: 5)
            
            XCTAssertEqual(rgba[channel: .red], rgb[channel: .red])
            XCTAssertEqual(rgba[channel: .green], rgb[channel: .green])
            XCTAssertEqual(rgba[channel: .blue], rgb[channel: .blue])
            XCTAssertEqual(rgba[channel: .alpha], Image(width: 3, height: 3, value: 5))
        }
        do {
            let data = (0..<27).map { Double($0) }
            let rgb = Image<RGB, Double>(width: 3, height: 3, data: data)
            let rgba = Image<RGBA, Double>(image: rgb, alpha: 0.5)
            
            XCTAssertEqual(rgba[channel: .red], rgb[channel: .red])
            XCTAssertEqual(rgba[channel: .green], rgb[channel: .green])
            XCTAssertEqual(rgba[channel: .blue], rgb[channel: .blue])
            XCTAssertEqual(rgba[channel: .alpha], Image(width: 3, height: 3, value: 0.5))
        }
    }
    
    func testRGBAtoRGB() {
        do {
            let data = (0..<36).map { Int($0) }
            let rgba = Image<RGBA, Int>(width: 3, height: 3, data: data)
            let rgb = Image<RGB, Int>(image: rgba)
            
            XCTAssertEqual(rgb[channel: .red], rgba[channel: .red])
            XCTAssertEqual(rgb[channel: .green], rgba[channel: .green])
            XCTAssertEqual(rgb[channel: .blue], rgba[channel: .blue])
        }
        do {
            let data = (0..<36).map { Double($0) }
            let rgba = Image<RGBA, Double>(width: 3, height: 3, data: data)
            let rgb = Image<RGB, Double>(image: rgba)
            
            XCTAssertEqual(rgb[channel: .red], rgba[channel: .red])
            XCTAssertEqual(rgb[channel: .green], rgba[channel: .green])
            XCTAssertEqual(rgb[channel: .blue], rgba[channel: .blue])
        }
    }
    
    func testARGBtoRGBA() {
        do {
            let data = (0..<36).map { Int($0) }
            let argb = Image<ARGB, Int>(width: 3, height: 3, data: data)
            let rgba = Image<RGBA, Int>(image: argb)
            
            XCTAssertEqual(rgba[channel: .red], argb[channel: .red])
            XCTAssertEqual(rgba[channel: .green], argb[channel: .green])
            XCTAssertEqual(rgba[channel: .blue], argb[channel: .blue])
            XCTAssertEqual(rgba[channel: .alpha], argb[channel: .alpha])
        }
        do {
            let data = (0..<36).map { Double($0) }
            let argb = Image<ARGB, Double>(width: 3, height: 3, data: data)
            let rgba = Image<RGBA, Double>(image: argb)
            
            XCTAssertEqual(rgba[channel: .red], argb[channel: .red])
            XCTAssertEqual(rgba[channel: .green], argb[channel: .green])
            XCTAssertEqual(rgba[channel: .blue], argb[channel: .blue])
            XCTAssertEqual(rgba[channel: .alpha], argb[channel: .alpha])
        }
    }
    
    func testRGBAtoARGB() {
        do {
            let data = (0..<36).map { Int($0) }
            let rgba = Image<RGBA, Int>(width: 3, height: 3, data: data)
            let argb = Image<ARGB, Int>(image: rgba)
            
            XCTAssertEqual(argb[channel: .red], rgba[channel: .red])
            XCTAssertEqual(argb[channel: .green], rgba[channel: .green])
            XCTAssertEqual(argb[channel: .blue], rgba[channel: .blue])
            XCTAssertEqual(argb[channel: .alpha], rgba[channel: .alpha])
        }
        do {
            let data = (0..<36).map { Double($0) }
            let rgba = Image<RGBA, Double>(width: 3, height: 3, data: data)
            let argb = Image<ARGB, Double>(image: rgba)
            
            XCTAssertEqual(argb[channel: .red], rgba[channel: .red])
            XCTAssertEqual(argb[channel: .green], rgba[channel: .green])
            XCTAssertEqual(argb[channel: .blue], rgba[channel: .blue])
            XCTAssertEqual(argb[channel: .alpha], rgba[channel: .alpha])
        }
    }
}
