import XCTest
import Swim

class SubscriptPerformanceTests: XCTestCase {
    func testChannelSubscriptGet() {
        let image = Image<RGBA, Double>(width :3840, height: 2160, value: 1)
        
        measure {
            _ = image[channel: .red]
        }
    }

    func testSubimageSubscriptGet() {
        let image = Image<RGBA, Double>(width :3840, height: 2160, value: 1)
        
        measure {
            _ = image[1..<1921, 1..<1081]
        }
    }
    
    func testChannelSubscriptSet() {
        var image = Image<RGBA, Double>(width :3840, height: 2160, value: 1)
        let red = Image<Gray, Double>(width :3840, height: 2160, value: 0)
        
        measure {
            image[channel: .red] = red
        }
    }
    
    func testSubimageSubscriptSet() {
        var image = Image<RGBA, Double>(width :3840, height: 2160, value: 1)
        let sub = Image<RGBA, Double>(width :1920, height: 1080, value: 0)
        
        measure {
            image[1..<1921, 1..<1081] = sub
        }
    }
}
