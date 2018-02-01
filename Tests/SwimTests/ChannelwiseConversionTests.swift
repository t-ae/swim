
import XCTest
import Swim

class ChannelwiseConversionTests: XCTestCase {
    func testChannelwiseConvert() {
        do {
            var image = Image<RGBA, Int>(width: 4, height: 5, data: (0..<80).map { Int($0) })
            image.channelwiseConvert { $0 * 2 }
            
            let expect = (0..<80).map { Int(2*$0) }
            XCTAssertEqual(image, Image(width: 4, height: 5, data: expect))
        }
        do {
            var image = Image<RGBA, Double>(width: 4, height: 5, data: (0..<80).map(Double.init))
            image.channelwiseConvert { $0 * 2 }
            
            let expect = (0..<80).map { Double(2*$0) }
            XCTAssertEqual(image, Image(width: 4, height: 5, data: expect))
        }
    }
}
