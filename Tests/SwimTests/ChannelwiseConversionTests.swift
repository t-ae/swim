
import XCTest
import Swim

class ChannelwiseConversionTests: XCTestCase {
    func testChannelwiseConvert() {
        var image = Image<RGBA, Double>(width: 4, height: 5, data: (0..<4*5*4).map(Double.init))
        image.channelwiseConvert { $0 * 2 }
        
        XCTAssertEqual(image.data, (0..<4*5*4).map { Double($0) * 2 })
    }
}
