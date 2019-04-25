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

}
