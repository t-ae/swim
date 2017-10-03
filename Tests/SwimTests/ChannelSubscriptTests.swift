
import XCTest
import Swim

class ChannelSubscriptTests: XCTestCase {
    
    func testChannelSubscriptGet() {
        let data = (0..<16).map { UInt8($0) }
        let image = Image<RGBA, UInt8>(width: 2, height: 2, data: data)
        
        let red = image[channel: 0]
        XCTAssertEqual(red, Image(width: 2, height: 2, data: [0, 4, 8, 12]))
        let green = image[channel: .green]
        XCTAssertEqual(green, Image(width: 2, height: 2, data: [1, 5, 9, 13]))
        let blue = image[channel: 2]
        XCTAssertEqual(blue, Image(width: 2, height: 2, data: [2, 6, 10, 14]))
        let alpha = image[channel: .alpha]
        XCTAssertEqual(alpha, Image(width: 2, height: 2, data: [3, 7, 11, 15]))
    }
    
    func testChannelSubscriptSet() {
        let data = (0..<16).map { UInt8($0) }
        var image = Image<RGBA, UInt8>(width: 2, height: 2, data: data)
        let newPixel = Image<Intensity, UInt8>(width: 2, height: 2, data: [252, 253, 254, 255])
        
        image[channel: 0] = newPixel
        XCTAssertEqual(image,
                       Image(width: 2, height: 2, data: [252, 1, 2, 3,
                                                         253, 5, 6, 7,
                                                         254, 9, 10, 11,
                                                         255, 13, 14, 15]))
        
        image[channel: .green] = newPixel
        XCTAssertEqual(image,
                       Image(width: 2, height: 2, data: [252, 252, 2, 3,
                                                         253, 253, 6, 7,
                                                         254, 254, 10, 11,
                                                         255, 255, 14, 15]))
        
        image[channel: 2] = newPixel
        XCTAssertEqual(image,
                       Image(width: 2, height: 2, data: [252, 252, 252, 3,
                                                         253, 253, 253, 7,
                                                         254, 254, 254, 11,
                                                         255, 255, 255, 15]))
        
        image[channel: .alpha] = newPixel
        XCTAssertEqual(image,
                       Image(width: 2, height: 2, data: [252, 252, 252, 252,
                                                         253, 253, 253, 253,
                                                         254, 254, 254, 254,
                                                         255, 255, 255, 255]))
        
        image[channel: .red][0, 0] = 0
        XCTAssertEqual(image,
                       Image(width: 2, height: 2, data: [0, 252, 252, 252,
                                                         253, 253, 253, 253,
                                                         254, 254, 254, 254,
                                                         255, 255, 255, 255]))
    }
    
}
