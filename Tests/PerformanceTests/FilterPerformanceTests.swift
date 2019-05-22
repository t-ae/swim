import XCTest
import Swim

class FilterPerformanceTests: XCTestCase {
    func testConvolution() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.convoluted(Filter.gaussian3x3)
        }
    }
    
    func testRankFilter() {
        let image = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.rankFilter(.maximum, kernelSize: 3)
        }
    }
    
    func testBilateralFilter() {
        let image = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.bilateralFilter(kernelSize: 5, sigma2_1: 1, sigma2_2: 0.01)
        }
    }
}
