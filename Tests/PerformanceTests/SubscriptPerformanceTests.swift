import XCTest
import Swim

class SubscriptPerformanceTests: XCTestCase {

    func testChannelSubscript() {
        let image = Image<RGBA, Double>(width :3840, height: 2160, value: 1)
        
        measure {
            for _ in 0..<10 {
                _ = image[channel: .red]
            }
        }
    }

    func testSubimageSubscript() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        var image = Image(width: 1920, height: 1080, rgb: data)
        
        measure {
            for _ in 0..<100_000 {
                image[0..<16, 0..<16] += 0.01
            }
        }
    }
}
