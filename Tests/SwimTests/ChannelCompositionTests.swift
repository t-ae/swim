
import XCTest
import Swim

class ChannelCompositionTests: XCTestCase {
    
    func testCompound() {
        do {
            let red = Image<Intensity, UInt8>(width: 2, height: 2, data: [0, 1, 2, 3])
            let green = Image<Intensity, UInt8>(width: 2, height: 2, data: [4, 5, 6, 7])
            let blue = Image<Intensity, UInt8>(width: 2, height: 2, data: [8, 9, 10, 11])
            
            let image = Image<RGB, UInt8>(r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
        }
        do {
            let red = Image<Intensity, Float>(width: 2, height: 2, data: [0, 1, 2, 3])
            let green = Image<Intensity, Float>(width: 2, height: 2, data: [4, 5, 6, 7])
            let blue = Image<Intensity, Float>(width: 2, height: 2, data: [8, 9, 10, 11])
            let alpha = Image<Intensity, Float>(width: 2, height: 2, data: [12, 13, 14, 15])
            
            let image = Image<RGBA, Float>(r: red, g: green, b: blue, a: alpha)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        do {
            let red = Image<Intensity, Double>(width: 2, height: 2, data: [0, 1, 2, 3])
            let green = Image<Intensity, Double>(width: 2, height: 2, data: [4, 5, 6, 7])
            let blue = Image<Intensity, Double>(width: 2, height: 2, data: [8, 9, 10, 11])
            let alpha = Image<Intensity, Double>(width: 2, height: 2, data: [12, 13, 14, 15])
            
            let image = Image<ARGB, Double>(a: alpha, r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
    }
}
