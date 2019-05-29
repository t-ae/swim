import XCTest
import Swim

class BayerPerformanceTests: XCTestCase {
    func testBayer() {
        let image = Image<RGB, Double>(width: 3840, height: 2160, value: 0)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.convert(image: image)
        }
    }
    
    func testDemosaic() {
        let image = Image<Gray, Double>(width: 3840, height: 2160, value: 0)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.demosaic(image: image)
        }
    }
    
    func testDemosaic_Int() {
        let image = Image<Gray, Int>(width: 3840, height: 2160, value: 0)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.demosaic(image: image)
        }
    }
}
