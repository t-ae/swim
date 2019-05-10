import XCTest
import Swim

class BayerPerformanceTests: XCTestCase {
    func testBayer() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        let image = Image(width: 1920, height: 1080, rgb: data)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.convert(image: image)
        }
    }
    
    func testDemosaic() {
        let data = [Float](repeating: 0, count: 1920*1080)
        let image = Image(width: 1920, height: 1080, intensity: data)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.demosaic(image: image)
        }
    }
    
    func testDemosaic_Int() {
        let data = [Int](repeating: 0, count: 1920*1080)
        let image = Image(width: 1920, height: 1080, intensity: data)
        
        let conv = BayerConverter(pattern: .bggr)
        
        measure {
            _ = conv.demosaic(image: image)
        }
    }
}
