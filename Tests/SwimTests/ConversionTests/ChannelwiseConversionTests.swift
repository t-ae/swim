import XCTest
import Swim

class ChannelwiseConversionTests: XCTestCase {
    func testChannelwiseConvert() {
        var image = Image(width: 4, height: 5, rgba: (0..<80).map { Int($0) })
        
        let expect = image.dataConverted { $0 * 2 }
        
        XCTAssertEqual(image.channelwiseConverted { x, y, c, value in
            value * 2
        }, expect)
        
        image.channelwiseConvert { x, y, c, value in
            value * 2
        }
        XCTAssertEqual(image, expect)
    }
    
    func testConvertChannel() {
        var image = Image(width: 4, height: 5, rgba: (0..<80).map { Int($0) })
        
        var expect = image
        expect[channel: .green] *= 2
        
        image.channelwiseConvert(channel: .green) { x, y, value in
            value * 2
        }
        
        XCTAssertEqual(image, expect)
    }
    
    func testConvertRange() {
        var image = Image(width: 4, height: 5, rgba: (0..<80).map { Int($0) })
        
        var expect = image
        expect[1..<3, 2..<4] += 1
        
        image.channelwiseConvert(1..<3, 2..<4) { x, y, c, value in
            value + 1
        }
        
        XCTAssertEqual(image, expect)
    }
    
    static let allTests = [
        ("testChannelwiseConvert", testChannelwiseConvert),
        ("testConvertChannel", testConvertChannel)
    ]
}
