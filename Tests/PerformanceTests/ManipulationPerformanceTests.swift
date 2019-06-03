import XCTest
import Swim

class ManipulationPerformanceTests: XCTestCase {
    func testAbs() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.applyAbs()
        }
    }

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
    
    func testTrunc() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.applyTrunc()
        }
    }

    func testClip() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.clip(low: 0, high: 1)
        }
    }
    
    func testPow() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.applyPow(2)
        }
    }
}
