import XCTest
import Swim

class ClipPerformanceTests: XCTestCase {
    func testClip() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            for _ in 0..<10 {
                image.clip(low: 0, high: 1)
            }
        }
    }
}
