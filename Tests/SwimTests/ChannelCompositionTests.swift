
import XCTest
import Swim

class ChannelCompositionTests: XCTestCase {
    
    func testCompound() {
        do {
            let red = Image(width: 2, height: 2, intensity: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, intensity: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, intensity: [8, 9, 10, 11])
            
            let image = Image(r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
        }
        do {
            let red = Image(width: 2, height: 2, intensity: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, intensity: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, intensity: [8, 9, 10, 11])
            let alpha = Image(width: 2, height: 2, intensity: [12, 13, 14, 15])
            
            let image = Image(r: red, g: green, b: blue, a: alpha)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        do {
            let red = Image(width: 2, height: 2, intensity: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, intensity: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, intensity: [8, 9, 10, 11])
            let alpha = Image(width: 2, height: 2, intensity: [12, 13, 14, 15])
            
            let image = Image(a: alpha, r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
    }
}
