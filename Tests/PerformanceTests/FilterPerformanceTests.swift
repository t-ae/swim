import XCTest
import Swim

class FilterPerformanceTests: XCTestCase {
    func testConvolution() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.convoluted(Filter.gaussian3x3)
        }
    }
    
    func testRankFilterMaximum() {
        let image = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.rankFilter(.maximum, windowSize: 3)
        }
    }
    
    func testRankFilterMedian() {
        let image = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.rankFilter(.median, windowSize: 3)
        }
    }
    
    func testBilateralFilter() {
        let image = Image<RGB, Double>.createWithUnsafeMutableBufferPointer(width: 640, height: 480) {
            for i in 0..<$0.count {
                $0[i] = sin(Double(i))
            }
        }
        
        measure {
            _ = image.bilateralFilter(windowSize: 5, distanceSigma: 1, valueSigma: 0.1)
        }
    }
    
    func testNLMeanFilter() {
        let image = Image<RGB, Double>.createWithUnsafeMutableBufferPointer(width: 640, height: 480) {
            for i in 0..<$0.count {
                $0[i] = sin(Double(i))
            }
        }
        
        measure {
            _ = image.nonLocalMeanFilter(windowSize: 5, sigma: 0.1)
        }
    }
}
