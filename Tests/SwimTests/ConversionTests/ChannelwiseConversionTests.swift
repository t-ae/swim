import XCTest
import Swim

class ChannelwiseConversionTests: XCTestCase {
    func testChannelwiseConvert() {
        do {
            var image = Image(width: 4, height: 5, rgba: (0..<80).map { Int($0) })
            image.channelwiseConvert { x, y, c, value in
                value * 2
                
            }
            
            let expect = (0..<80).map { Int(2*$0) }
            XCTAssertEqual(image, Image(width: 4, height: 5, data: expect))
        }
        do {
            var image = Image(width: 4, height: 5, rgba: (0..<80).map(Double.init))
            image.channelwiseConvert { x, y, c, value in
                value * 2
            }
            
            let expect = (0..<80).map { Double(2*$0) }
            XCTAssertEqual(image, Image(width: 4, height: 5, data: expect))
        }
    }
    
    static let allTests = [
        ("testChannelwiseConvert", testChannelwiseConvert)
    ]
}
