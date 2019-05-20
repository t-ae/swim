import XCTest
import Swim

class ChannelCompositionTests: XCTestCase {
    
    func testCompound() {
        do {
            let gray = Image(width: 2, height: 2, gray: [0, 1, 2, 3])
            let alpha = Image(width: 2, height: 2, gray: [4, 5, 6, 7])
            
            let image = Image(gray: gray, alpha: alpha)
            
            XCTAssertEqual(image[channel: .gray], gray)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        do {
            let red = Image(width: 2, height: 2, gray: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, gray: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, gray: [8, 9, 10, 11])
            
            let image = Image(r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
        }
        do {
            let red = Image(width: 2, height: 2, gray: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, gray: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, gray: [8, 9, 10, 11])
            let alpha = Image(width: 2, height: 2, gray: [12, 13, 14, 15])
            
            let image = Image(r: red, g: green, b: blue, a: alpha)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        do {
            let red = Image(width: 2, height: 2, gray: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, gray: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, gray: [8, 9, 10, 11])
            let alpha = Image(width: 2, height: 2, gray: [12, 13, 14, 15])
            
            let image = Image(a: alpha, r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        
        do {
            let rgb = Image<RGB, UInt8>(width: 2, height: 2, data: (0..<12).map { UInt8($0) })
            let a = Image<Gray, UInt8>(width: 2, height: 2, data: (13..<17).map { UInt8($0) })
            
            let rgba = Image(rgb: rgb, a: a)
            XCTAssertEqual(rgba[channel: .red], rgb[channel: .red])
            XCTAssertEqual(rgba[channel: .green], rgb[channel: .green])
            XCTAssertEqual(rgba[channel: .blue], rgb[channel: .blue])
            XCTAssertEqual(rgba[channel: .alpha], a)
            
            let argb = Image(a: a, rgb: rgb)
            XCTAssertEqual(argb[channel: .red], rgb[channel: .red])
            XCTAssertEqual(argb[channel: .green], rgb[channel: .green])
            XCTAssertEqual(argb[channel: .blue], rgb[channel: .blue])
            XCTAssertEqual(argb[channel: .alpha], a)
        }
    }
}
