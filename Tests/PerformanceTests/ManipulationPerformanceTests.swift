import XCTest
import Swim

class ManipulationPerformanceTests: XCTestCase {

    func testFloor() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.applyFloor()
        }
    }
    
    func testCeil() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.applyCeil()
        }
    }
    
    func testRound() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.applyRound()
        }
    }

    func testClip() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.clip(low: 0, high: 1)
        }
    }
}
