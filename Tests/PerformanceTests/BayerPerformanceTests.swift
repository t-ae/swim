import XCTest
import Swim

class BayerPerformanceTests: XCTestCase {
    func testBayer() {
        let image = Image<RGB, Double>(width: 1920, height: 1080, value: 0)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.convert(image: image)
        }
    }
    
    func testDemosaic() {
        let image = Image<Intensity, Double>(width: 1920, height: 1080, value: 0)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.demosaic(image: image)
        }
    }
    
    func testDemosaic_Int() {
        let image = Image<Intensity, Int>(width: 1920, height: 1080, value: 0)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.demosaic(image: image)
        }
    }
}
