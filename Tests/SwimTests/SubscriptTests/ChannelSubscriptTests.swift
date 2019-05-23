import XCTest
import Swim

class ChannelSubscriptTests: XCTestCase {
    
    func testChannelSubscriptGet() {
        do {
            let data = (0..<16).map { UInt8($0) }
            let image = Image(width: 2, height: 2, rgba: data)
            
            let red1 = image[channel: 0]
            XCTAssertEqual(red1, Image(width: 2, height: 2, data: [0, 4, 8, 12]))
            let red2 = image[channel: .red]
            XCTAssertEqual(red2, Image(width: 2, height: 2, data: [0, 4, 8, 12]))
            let green1 = image[channel: 1]
            XCTAssertEqual(green1, Image(width: 2, height: 2, data: [1, 5, 9, 13]))
            let green2 = image[channel: .green]
            XCTAssertEqual(green2, Image(width: 2, height: 2, data: [1, 5, 9, 13]))
            let blue1 = image[channel: 2]
            XCTAssertEqual(blue1, Image(width: 2, height: 2, data: [2, 6, 10, 14]))
            let blue2 = image[channel: .blue]
            XCTAssertEqual(blue2, Image(width: 2, height: 2, data: [2, 6, 10, 14]))
            let alpha1 = image[channel: 3]
            XCTAssertEqual(alpha1, Image(width: 2, height: 2, data: [3, 7, 11, 15]))
            let alpha2 = image[channel: .alpha]
            XCTAssertEqual(alpha2, Image(width: 2, height: 2, data: [3, 7, 11, 15]))
        }
        do {
            let data = (0..<16).map { Float($0) }
            let image = Image(width: 2, height: 2, rgba: data)
            
            let red = image[channel: 0]
            XCTAssertEqual(red, Image(width: 2, height: 2, data: [0, 4, 8, 12]))
            let green = image[channel: .green]
            XCTAssertEqual(green, Image(width: 2, height: 2, data: [1, 5, 9, 13]))
            let blue = image[channel: 2]
            XCTAssertEqual(blue, Image(width: 2, height: 2, data: [2, 6, 10, 14]))
            let alpha = image[channel: .alpha]
            XCTAssertEqual(alpha, Image(width: 2, height: 2, data: [3, 7, 11, 15]))
        }
        do {
            let data = (0..<16).map { Double($0) }
            let image = Image(width: 2, height: 2, rgba: data)
            
            let red = image[channel: 0]
            XCTAssertEqual(red, Image(width: 2, height: 2, data: [0, 4, 8, 12]))
            let green = image[channel: .green]
            XCTAssertEqual(green, Image(width: 2, height: 2, data: [1, 5, 9, 13]))
            let blue = image[channel: 2]
            XCTAssertEqual(blue, Image(width: 2, height: 2, data: [2, 6, 10, 14]))
            let alpha = image[channel: .alpha]
            XCTAssertEqual(alpha, Image(width: 2, height: 2, data: [3, 7, 11, 15]))
        }
    }
    
    func testChannelSubscriptSet() {
        do {
            let data = (0..<16).map { UInt8($0) }
            var image = Image(width: 2, height: 2, rgba: data)
            let newValue = Image(width: 2, height: 2, gray: [252, 253, 254, 255] as [UInt8])
            
            image[channel: 0] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 1, 2, 3,
                                                             253, 5, 6, 7,
                                                             254, 9, 10, 11,
                                                             255, 13, 14, 15]))
            
            image[channel: .green] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 2, 3,
                                                             253, 253, 6, 7,
                                                             254, 254, 10, 11,
                                                             255, 255, 14, 15]))
            
            image[channel: 2] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 252, 3,
                                                             253, 253, 253, 7,
                                                             254, 254, 254, 11,
                                                             255, 255, 255, 15]))
            
            image[channel: .alpha] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 252, 252,
                                                             253, 253, 253, 253,
                                                             254, 254, 254, 254,
                                                             255, 255, 255, 255]))
            
            image[channel: .red][0, 0, 0] = 0
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [0, 252, 252, 252,
                                                             253, 253, 253, 253,
                                                             254, 254, 254, 254,
                                                             255, 255, 255, 255]))
        }
        do {
            let data = (0..<16).map { Float($0) }
            var image = Image(width: 2, height: 2, rgba: data)
            let newValue = Image(width: 2, height: 2, gray: [252, 253, 254, 255] as [Float])
            
            image[channel: 0] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 1, 2, 3,
                                                             253, 5, 6, 7,
                                                             254, 9, 10, 11,
                                                             255, 13, 14, 15]))
            
            image[channel: .green] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 2, 3,
                                                             253, 253, 6, 7,
                                                             254, 254, 10, 11,
                                                             255, 255, 14, 15]))
            
            image[channel: 2] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 252, 3,
                                                             253, 253, 253, 7,
                                                             254, 254, 254, 11,
                                                             255, 255, 255, 15]))
            
            image[channel: .alpha] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 252, 252,
                                                             253, 253, 253, 253,
                                                             254, 254, 254, 254,
                                                             255, 255, 255, 255]))
            
            image[channel: .red][0, 0, 0] = 0
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [0, 252, 252, 252,
                                                             253, 253, 253, 253,
                                                             254, 254, 254, 254,
                                                             255, 255, 255, 255]))
        }
        do {
            let data = (0..<16).map { Double($0) }
            var image = Image(width: 2, height: 2, rgba: data)
            let newValue = Image(width: 2, height: 2, gray: [252.0, 253, 254, 255])
            
            image[channel: 0] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 1, 2, 3,
                                                             253, 5, 6, 7,
                                                             254, 9, 10, 11,
                                                             255, 13, 14, 15]))
            
            image[channel: .green] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 2, 3,
                                                             253, 253, 6, 7,
                                                             254, 254, 10, 11,
                                                             255, 255, 14, 15]))
            
            image[channel: 2] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 252, 3,
                                                             253, 253, 253, 7,
                                                             254, 254, 254, 11,
                                                             255, 255, 255, 15]))
            
            image[channel: .alpha] = newValue
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [252, 252, 252, 252,
                                                             253, 253, 253, 253,
                                                             254, 254, 254, 254,
                                                             255, 255, 255, 255]))
            
            image[channel: .red][0, 0, 0] = 0
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [0, 252, 252, 252,
                                                             253, 253, 253, 253,
                                                             254, 254, 254, 254,
                                                             255, 255, 255, 255]))
        }
    }
    
    static let allTests = [
        ("testChannelSubscriptGet", testChannelSubscriptGet),
        ("testChannelSubscriptSet", testChannelSubscriptSet)
    ]
}
