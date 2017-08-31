
import XCTest
import Swim

class ChannelSubscriptTests: XCTestCase {
    
    func testChannelSubscriptGet() {
        let data = (0..<16).map { UInt8($0) }
        let image = Image<RGBA, UInt8>(width: 2, height: 2, data: data)
        
        let red = image[channel: 0]
        XCTAssertEqual(red.data, [0, 4, 8, 12])
        let green = image[channel: .green]
        XCTAssertEqual(green.data, [1, 5, 9, 13])
        let blue = image[channel: 2]
        XCTAssertEqual(blue.data, [2, 6, 10, 14])
        let alpha = image[channel: .alpha]
        XCTAssertEqual(alpha.data, [3, 7, 11, 15])
    }
    
}
