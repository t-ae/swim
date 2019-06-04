import XCTest
import Swim

class ArithmeticPerformanceTests: XCTestCase {
    func testMulScalar() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            for _ in 0..<10 {
                image *= 1.1
            }
        }
    }
    
    func testMulScalarEquivalent() {
        var image = [Double](repeating: 1, count: 3840*2160*4)
        
        measure {
            for _ in 0..<10 {
                for i in 0..<image.count {
                    image[i] *= 1.1
                }
            }
        }
    }
    
    func testMulPixel() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let color = Color<RGBA, Double>(r: 0.9, g: 1.1, b: 0.9, a: 1.1)
        
        measure {
            for _ in 0..<10 {
                image *= color
            }
        }
    }
    
    func testMulPixelEquivalent() {
        var image = [Double](repeating: 1, count: 3840*2160*4)
        let color = [0.9, 1.1, 0.9, 1.1]
        
        measure {
            for _ in 0..<10 {
                for i in 0..<image.count/4 {
                    for j in 0..<4 {
                        image[4*i+j] *= color[j]
                    }
                }
            }
        }
    }
    
    func testMulImage() {
        var image1 = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let image2 = Image<RGBA, Double>(width: 3840, height: 2160, value: 1.1)
        
        measure {
            for _ in 0..<10 {
                image1 *= image2
            }
        }
    }
    
    func testMulImageEquivalent() {
        var image1 = [Double](repeating: 1, count: 3840*2160*4)
        var image2 = [Double](repeating: 1.1, count: 3840*2160*4)
        
        measure {
            for _ in 0..<10 {
                for i in 0..<image1.count {
                    image1[i] *= image2[i]
                }
            }
        }
    }
}
