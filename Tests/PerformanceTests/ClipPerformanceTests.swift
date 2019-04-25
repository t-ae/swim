import XCTest
import Swim

class ClipPerformanceTests: XCTestCase {
    func testClip() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            _ = image.clipped(low: 0, high: 1)
        }
    }
}
